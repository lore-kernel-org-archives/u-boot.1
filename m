Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFB1CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 17:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AED481E18;
	Mon, 11 May 2026 19:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="VgQEDDBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF338341A; Mon, 11 May 2026 19:25:23 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1419B803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 19:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd11a3729e8so128774066b.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520320; cv=none;
 d=google.com; s=arc-20240605;
 b=YA4KIzRoV+AnOjhTkCTSpbO1Lk8+U2vXVU4CoC/wAF2/t9OIkXlLQUDxAYlMsxh7oJ
 PeeiHbC4fC0PC8RjJL5uUrSqZV1PXh9ypMyQrX+gm4G76ZhBqn6Mca9PdXh31bQnRY5j
 lKgNjdcR6mNS4kCyPMEXTBXtIJiCCkU8twPvTVFkjgBt7tJG5wy0TPnMxmOyfoPcthDu
 fpQ11a4lCKdiZ4VkJ1AyKaw+60m3wLEBNd06Mv/7tc6t7Qh0p8tmljPYEQM3sMsJjYRN
 iwY21wUaBoufxBnmIHX8k0x3kzs3t61N7Fg0Yvbbc0Lxp+phnmfyDnagkwfvJRocUD3O
 3UJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mw/4ZfGlXZqwdkNyScg2W0Genv4sww26aUdjmTklXyY=;
 fh=Qu0pkaxWK7tNOa/Jlih+nW5PEEuNwPOHHmDwYqI9Yls=;
 b=k7h197kD4YIGAMmcjZD3dxojX7IUB6li8VhpjsLJAU4EqP9VUD51Zgjncj11YOvUWt
 COV7FD5EGZCcrCu+0IYrb+ar8zyfUJN3gA3Q8w4Ku7MY7RdmEc5h3rqJ3gcMql36BgQr
 bSAuM1D18SylskhvWrvDYs4Sq/zL9cyMvhME65I6uW6SXABfi8Rmxd88mplsv7SkooPo
 6BT4jLEejN4dnR5QzHRzppuBJjP//rLVAcOJdsLaq5eu2UJ5Ph3sEGCQjVgnTPCebqTk
 VML6IBwt/QErj6KYAWLpwLUm6m9/TPoez7AiCckOFPPY+m2sjnxIcZ2JGuYvLDlmex9i
 MekA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778520320; x=1779125120; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mw/4ZfGlXZqwdkNyScg2W0Genv4sww26aUdjmTklXyY=;
 b=VgQEDDBql9CSDX0ob0coJWsJNTVKrqZXERBScx3lf87FGODAx2g8KrXdj6POJHh24n
 lMlnLrUCfdg5KN5/ZQpR8L5E6zWXGCKEf+sMRYt/Emv62WaJDdEVtinz6axd/QusTJ7h
 QhQbGIOXMcVbi0voodEmkHz6byaHLQTqMH2lhYlY9IGDxNRlcWzPKjFYDZHmQ6QYcrBz
 tc9Ikkk864G5YUrCRZjoE3MbUZDT8iC/IEEbl8Icc2i258q/DEl3mxeQoUzGgqUXtNdd
 /FiCJW0i6jafjeAC6U1mc/nhG02Fj51uamMiM1M0nxBaf/AGuwshHm/YGjiGMtqhsxyV
 2Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778520320; x=1779125120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mw/4ZfGlXZqwdkNyScg2W0Genv4sww26aUdjmTklXyY=;
 b=GMTu2OJUm46jIYUtxL/FmWcFmX1GuQ5M/TCSKyfjUWCczgaDRTo8oTBh8yvi+xhz7Y
 cUKj+/2/ZTP00FcQnGxxvLPHznLgFHwwUTbr+pwqsc4bhbmiCOMsrzqQy949zchCkEZJ
 C0QE39CjRpt5FwALFs1m3s8tqEscBdAYgci8FGYgMj2Zeq73xwwmDnyD4C4SobhYskDk
 F8+E9lLmQ9jaH9p8aOtkmYiSuVT+Jh2QVX3HjslohK9QGABDZuV0CrN9TyQHACeaVY4Y
 4oPTqU7cMVOKNcv61bPKEtGDUhvkz4EzbCGJQ+9i3kh/gBzbtwt1yj6NWJLSvo5Hs7rN
 s6Ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UQECWlMJiUqa3PmP9ho79rPNb2ao2ZFwE42qukksVvC9825kOW1QkYdNH1DhlsPrzmkU2st4=@lists.denx.de
X-Gm-Message-State: AOJu0YwXOsIyNsfKL2wfbi5h0SscnrPBBq2uOzt7vhnnI7QLWH5xz6iK
 ZBk7zSoCNerpgU+qVcaFcqYi0xIANhdRXiJbUY1e9UGVzDWUWH3TiCmsOLE6N38hYBm/P8J1HJU
 L+izeo0Whfa4f6kMJEaJ4Ty3m0J5uwM1yCTKx0CywPA==
X-Gm-Gg: Acq92OE7AG4Acl4Q5zQfBUmHjxc3zfCg4lyJOu5dBpCQil3lEO2TpJZsF1bj5N8NqLU
 Fs4VsVNmz9P7awkn56Uw3HifYkWyCC1m11VR+adv/NqLeLfx5TIDlKL28WeO2jgNbOm45Jsb+xV
 gQdjyx30z+dBOcFE5YpWkNPBqZP4FavME7dRZPvKjk0MODE1fIKl+f6MkaUiBGaEV+/AXcgFyqB
 9bE4D0gHcxmXp+2P5BLa3sLjrB0x7sPe405Pq2MyGxFRpkoQJ8ZFuNfhi6oto6lQ0Xq2yswoteK
 LJku+60ou4aAtp/M1SL9IqDcB7iLjsaD5Lpvdklz
X-Received: by 2002:a17:907:d18:b0:bd1:e34f:8364 with SMTP id
 a640c23a62f3a-bd1e34f895amr135111366b.36.1778520319901; Mon, 11 May 2026
 10:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
In-Reply-To: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 11 May 2026 21:25:09 +0400
X-Gm-Features: AVHnY4ISKKdhT1ygqI3H3yWlpEsex9v-1OQthJmWe9TnKv_yJ61rPQhWli6kX94
Message-ID: <CAKTNdwE-EoFvODNztD8HsS6C9GcjkMARNndYjTTDaXPTHFiAeA@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 11, 2026 at 9:21=E2=80=AFPM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> The dwc3_free_one_event_buffer() function incorrectly called free()
> on event buffer structures allocated with devm_kzalloc(). This
> caused heap corruption and a synchronous abort when exiting
> fastboot mode via "fastboot continue".
>
> Device-managed memory is automatically freed when the device is
> removed, so manual deallocation causes the heap allocator to access
> corrupted metadata.
>
> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer c=
leanup")
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Move Fixes tag to commit footer in commit description
> - Link to v2: https://lore.kernel.org/u-boot/20260507-usb-v2-1-3958b87325=
53@oss.qualcomm.com/
>
> Changes in v2:
> - Added Fixes tag in commit description
> - Link to v1: https://lore.kernel.org/u-boot/20260506-usb-v1-1-e0f426bb1e=
42@oss.qualcomm.com/
> ---
>  drivers/usb/dwc3/core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 0dee14c8b59..be198041f08 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct dwc3 *d=
wc,
>                 struct dwc3_event_buffer *evt)
>  {
>         dma_free_coherent(evt->buf);
> -       free(evt);

Thanks for the fix Balaji! This fixed a crash I've been seeing on
Rockchip RK3576 trying to use the UMS gadget, so

Tested-by: Alexey Charkov <alchark@flipper.net>
Closes: https://lore.kernel.org/u-boot/CAKTNdwHA_3eJ4D7maBmAAr1DyrvT_meMsJ7=
_Naux1dKTzOu3OQ@mail.gmail.com/

Best regards,
Alexey
