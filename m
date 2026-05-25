Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD72CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB59B84862;
	Mon, 25 May 2026 17:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DhHQRxcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D80848B0; Mon, 25 May 2026 17:16:28 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89688482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so1815605266b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722185; cv=none;
 d=google.com; s=arc-20240605;
 b=aPanNXO3LqRbF9NARWuekCKnG7Qg8i7zAhAGLIBelHDRTSPrpHtUKQ4i2yFQ9pHVRN
 Vzz9zMtQ5OQnPK/dp7MM7Pdm65/LP1zz6PXkvniuC6mbpnUEPd0up/35MoMeCrlMBIMC
 GmkUxBLupx8bDnso6dEvGJyDSkj9IHhBOnyIT6d5B/0HBxZQUOFmvz/mguk+6LJ5JdTU
 hfSFnlRfzIfKD7ltbEl3fIw7jGdPxFlJG6TSuwKi22f1qzrXPN1i6/sV+JA9R52nXrPL
 Eq8gxnTrVJI+fDTsbnn4gT0aw28RNz2P8lEHMjSsuJ1y6xudUhyh6x+CKtAXbqbyHe2y
 LLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dW5snH6e3VmU1GgWD9oywQMZTF1937K6HDS1h3m4xxY=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=lVyOHVOPVyLmr8b7OwP0ylk0AgCHtDOLUcMltwU7L54h1z561oKLjVjhZ7K3zTQbLg
 MKHrweMi6nUgnLkJySWJzA40BI/TRuEWDBs31rpAfnCPh7VCr9H9vtxDVlyM7SMDwkjJ
 7+9GroIU0y70GqgyTJPdmomWOwAV2I82P2Um8GIAnJXRqdfrMayPLmFYfv/N78KVEZKi
 n5r2fe43/A8OtJ0ZXEjjmQHBPIW5Xe7bowlpmrL6ZeivCNfEDzAq3n7H+1PNx5LK0MNc
 fxoRtGJyec5TkIyPjdgzAZ+ipivnRadmNcCqWym4jjmRmDxjRTcEJlq7/rlA5/lIbjqx
 VcAA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722185; x=1780326985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dW5snH6e3VmU1GgWD9oywQMZTF1937K6HDS1h3m4xxY=;
 b=DhHQRxcGXu9x1sSYf3gN3psPiLoRe+eQXh5U+jJetjSXvPQWz2NTSekz6HGn8Lpb31
 uUqTfpH8Nh14jsVMX7KTK94nhZ3g/4SPLbQRdIRWyb1tACPkm9HPFRy+FlPX+QgxDMYp
 WGEHf2UHV2kZYXKER+32iSufi1a157zcisS/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722185; x=1780326985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW5snH6e3VmU1GgWD9oywQMZTF1937K6HDS1h3m4xxY=;
 b=ASoycWAzpVC0LD5xTx6WEXJqzfe75Uiu1JwWZHisk7PymThddCMOOqU0iotDNMKyUN
 qhSHcm9J02lY2AvJl1tgmRCPKqP/6MUqcExFZdwIN/g6zBLCLffM+OiZ/hIA+VU7QfO8
 CmM/uaHw4ueV5l1YTXGgYMCeXs5r2X/bdQ9atpgWgrG5BZAoFgvL6F0QAKYgGhSxYx7k
 cN099DFbXJeiSAqPLOcmU8DYNRcRf+WwNvTguZfFyXe1FCy/Xu+7tpQ811aMHuswFxG2
 5wDRaxsAo4AX5061EXe2JBv1K16yp5uIZWvOrc3eEyte7CBOBIu2NUGs0WhhcTGPjTXu
 WGeQ==
X-Gm-Message-State: AOJu0YxBkH9T0zMwMU/WBZpmh1A0+Gv21CngYNXekPATr4QqFiTbctbZ
 zGfmxG6fWr+DKreBOsWIPSpwLB+GY8ls+iv5a9fgPEmDRtmYgCr15STgT8xWr8uAnQAbXkh1c3h
 eK0QyjjrYX2nEM3aXXeFCOxoqNwp4PwBuppcBSyt4HX05s4oTwOc=
X-Gm-Gg: Acq92OEWNahU06QTvzSdDFPHUpIZmeOhQhB5Fyfv5QuUB2+907GzqstbYReNmLzQGxM
 UESdt5USuPHl8qVUzYXblAoy/nRQby2WEdRFdR/nvjRDXp/ZhOYjSCO/vfT7vXwk19ZN+EKqQxt
 IFWvoBtCwQnLQkBEQWWspB7nQX9r0e/7+HjX0dJb/92MFOEp7dma2vq8JDoaKotlOHOIkNUyw2x
 0NQOEgxHk5Vrza4tQjdhUZJSNX84eFRRWc0do3+i7xmV5/zjhZJFSS/3hRcB4RYcXXm254MqjDz
 FyYNFQ==
X-Received: by 2002:a17:907:25c8:b0:bdb:4372:b152 with SMTP id
 a640c23a62f3a-bdd4a3b1f6emr661660666b.16.1779722185207; Mon, 25 May 2026
 08:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260522024001.185760-1-weijie.gao@mediatek.com>
In-Reply-To: <20260522024001.185760-1-weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:16:13 -0600
X-Gm-Features: AVHnY4KL-b4OqvhJtYdPmD58HoQ-8ixFxucRBmkv5mTkGVynczFGnxeHUU3fCbQ
Message-ID: <CAFLszTgKjUOC4-JGg0wYrPT2NXfxccQbqAmErWBhYgJT7tOS_A@mail.gmail.com>
Subject: Re: [PATCH] bootmenu: fix incorrect menu quitting logic
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Weijie,

On 2026-05-22T02:40:01, Weijie Gao <weijie.gao@mediatek.com> wrote:
> bootmenu: fix incorrect menu quitting logic
>
> The last entry of bootmenu is always set for exitting the menu, and
> its command is set to an empty string.
>
> When user selects to quit the menu, bootmenu will try to run this
> empty command. However run_command() with empty cmd string will
> return failure, and the return value will be overridden to
> BOOTMENU_RET_FAIL, not the expected BOOTMENU_RET_QUIT.
>
> This patch adds a default success value to the cmd_ret variable, and
> add make sure run_command() be called only when menu command is not
> empty.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/bootmenu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
> @@ -526,7 +526,7 @@ static void handle_uefi_bootnext(void)
>   */
>  static enum bootmenu_ret bootmenu_show(int uefi, int delay)
>  {
> -     int cmd_ret;
> +     int cmd_ret = CMD_RET_SUCCESS;

Nice catch!

> bootmenu: fix incorrect menu quitting logic
>
> The last entry of bootmenu is always set for exitting the menu, and
> its command is set to an empty string.

'exitting' should be 'exiting', and 'and add make sure run_command()
be called only when menu command is not empty' should read 'and makes
sure run_command() is called only when the menu command is not empty'.

With those:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
