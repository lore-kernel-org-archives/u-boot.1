Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F03C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2F55606B4;
	Mon,  3 Aug 2026 19:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JTveL1hI7MR; Mon,  3 Aug 2026 19:25:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 983C16066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785141;
	bh=m3upQwbW1hueoZ34UXpOF7kpVPgqYstW8pw5gvN9wLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R342xZc8EitMUTU529eQvIPf4xZ9B/QAw4jNq0TspohdVulHF6v4mbPAw59xqIiik
	 QuU8ZiabxiBxA+eswslMv4oNbZtZ261dHogqvaYpjNf8zg+qzu9rRffmmlc/RvaCgG
	 QsfcjiVf9XRYSKpGjeO9LRI1u5BzWjOlpXkZ5fYsC86IPtae1o1VGe7dJQXUIeo5t4
	 figwFv/AqSB23NUwloOpUrG63i4KE/OaZj70XskLr3mIeCJpfkG/PogAkOeC0BLt9N
	 xlp38DQ9KigtQ06WqDLMAH2p1kl7ERK/Z9rJpPn6ZHkwF5R8GiL6Og5v1xc00to/xV
	 97AompaRd5K8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 983C16066F;
	Mon,  3 Aug 2026 19:25:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE1B2194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96C8F405DC
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DAshbRw4E4Q for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:25:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5485B405D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5485B405D8
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5485B405D8
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:37 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso409444a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785135; cv=none;
 d=google.com; s=arc-20260327;
 b=ANp6r2CkWNYIAwgtdqq1qpUqLqTAJ4a/veHoQUx5wHeYd+Eafv8XdeM3HmGwB2mHfN
 d5UrxPxba0+CH/q8EUWnaUeg7tLnvwClvS64IsY87ABch8dUaG4wE4o19xhiFwZk4mGz
 qKa4130Z9faQTdTLxUH/t6eT0vIlm4sA+fghiAVExCh9O2neQIzdLdY6MNuKJbw+/n7X
 FZ42JILPVIhMLsniwQ+27q33HZ1r0wdQ7XZz6eXqJvJxC2M44E5v27UQZD0Wzgy1D1un
 ZXsTqJOFfDubYuTlhW1+0ynoIE8yeKfwnqHWxOvBFVeFir7klDJ5JfuQLU3bXhDe3yXN
 ZvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m3upQwbW1hueoZ34UXpOF7kpVPgqYstW8pw5gvN9wLY=;
 fh=BAgd4wGJUMeTTehyqqj62TlzEd4snBjWttdmAmgNoP0=;
 b=QE9T/qZ7pT1JN8WV28Pv2oCWEC/9L8lAqdKYyN3rVTm5B5ZU3nKPz4vQaJKKTQP/6W
 90K81KVhHLwwoE+0oJvGGZ+6J4ZJzSJTGEV/4zP1AihMhWc1rnzZR/DwTxaYCmkcjYAc
 1sEjL/cXtvPoYV2/F0EQi1Lz6sCW28AmvRaOJgUoYpjytHjHwkE/wb4A3CzNWlL1vNj3
 K5ffjJzMbiLzVpr1xgUJP/eI27mNvAzgeR3qJggl+diUXMvFcFhTIEVd+JRB/3fJZTnW
 Woh3QnQsN8GYzcsqfn+T2zz/ehgUCJGJAp66dOJe3CSrQ7IAObudX5i470gU7mqpEQob
 jQNA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785135; x=1786389935;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m3upQwbW1hueoZ34UXpOF7kpVPgqYstW8pw5gvN9wLY=;
 b=krhjopy9PFRs78zjVyPx3WljkwwinT+yNIsRLtyKGTFvihZMci4GDQd8yqCJG9JCys
 +p+ZjSWXb7PeUqiezHV2WRUyUO3ccRlu2HnXrCKMpNcg7gOdM5mBmIeth7mCjBZOn6XK
 bcQqwDIDmqAGk9uTa+Eyh1k1fMajFpHApKupbSmBu3UaqXKHSxV8I/X1URQqqGuqPHW/
 BUnnc89N7Sn0OQHFttB3J89xy6OY98E+kEHG4R642Bl4rXKPn4cFugbviNlh2nhpG11N
 d9/mWFZTD4wl5yNN40G1LylDcie54XU+SvMXPPj/POFtUMtudTcktIlOOW8miMBRzsAu
 PqAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKAdAm8Roi6Nv5bwg/HvcPhkTAXOqEFEU+IoMRq9HTt6cObdmPTu6AJ2zRkPWeiwMDE3HmOrM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx10Uj59RilWxnO5VbmUPNVneYuVptyGF2EVFGf4QpwNQlxhkh9
 yEmgcOGmuHGGVNxNqRyo8JInJ4qdwXE4BobE2QK0i24ppGxv87nA4tRyJultmnwK5qmQp8NxHlY
 fMiEeyftKsTJo+PWAQHkH5XMkcm1NjhscWQqz1ySd
X-Gm-Gg: AR+sD134JsDLPkrLq2byHp3SUGt0Pp/Mrg7ToHBnw53Gj3f8Y5GNYx64fYWgIOVY/gC
 sqCS238lGNSeVEJM2oiBp3t59cXbrI6ofT2B4zl6IqN83vKLgWciky8eMVyM9r7kDbJxSoX2hIH
 +yWEDAC6ABXNTEvE7ttDUXB58eLOfoSnd/mw//GtPuFWsLTa9R/kGvTC5cyLK/gU3aEoHIIh2ct
 a77TYf4ME+UCHjq51JEtKXdLlpMS5EkkkwAwjlpN8hyAVxVxlPf02JqWKTilw23CH9LlWbSG+Dr
 BBPkV00i0kb856YawU31nNhPWcmo31BSz2jdcq0S4qOajHp+vZcHYQ==
X-Received: by 2002:a05:6402:5383:b0:6a1:1742:ac22 with SMTP id
 4fb4d7f45d1cf-6a122e38796mr859023a12.2.1785785135216; Mon, 03 Aug 2026
 12:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-1-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-1-fb403348e29b@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:25:21 -0600
X-Gm-Features: AUfX_mxbEAgrTSVhX8-JVrK0wYgq-xgFsx49lmWzGLgJuXV9b3HcLembA4qwh40
Message-ID: <CAFLszThAUP-wJb_J5aX=jA-Wr_HawkUQvaAa1GVwSt+150FbNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: qemu: Describe pflash
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785135; x=1786389935;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m3upQwbW1hueoZ34UXpOF7kpVPgqYstW8pw5gvN9wLY=;
 b=TIXQ20jp23TdcFrCScAIkKCRS2CjvagEcw0ENBQiF5mlhdkjlvdj0ejbDFKldBcx6y
 7+r4qcgRTBFdpPBRStLKgbyHCyK7YNeHKwTGIM1ljDJRuc49Dp9TcnRtGFXfDqzki3VD
 zGGQ0JTL5LAjheAMbFnf2BOxbk6NW6CiDTiRI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TIXQ20jp
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Elliot,

On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> x86: qemu: Describe pflash
>
> QEMU pflash is mapped just below 4GiB. Describe it as a cfi-flash
> node so the MTD subsystem can probe it. When a flash device is not
> exposed to the guest by QEMU, the address is still backed by ROM, so
> we'll just see no flash found rather than faulting.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> arch/x86/dts/pflash.dtsi         | 14 ++++++++++++++
>  arch/x86/dts/qemu-x86_i440fx.dts |  1 +
>  arch/x86/dts/qemu-x86_q35.dts    |  1 +
>  3 files changed, 16 insertions(+)

> diff --git a/arch/x86/dts/pflash.dtsi b/arch/x86/dts/pflash.dtsi
> new file mode 100644
> index 00000000000..ce69bcc6865
> --- /dev/null
> +++ b/arch/x86/dts/pflash.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * QEMU pflash (CFI NOR) mapped just below 4GiB. QEMU aligns the pflash so
> + * that it ends at the top of the 32-bit address space.
> + * https://gitlab.com/qemu-project/qemu/-/blob/e1705a25aff35635c360bbaba4c2731d019a422a/hw/i386/pc_sysfw.c#L128
> + */

The link pins a QEMU commit hash which might go away. Please point at
a stable ref (a release tag, or just hw/i386/pc_sysfw.c on -master).

> diff --git a/arch/x86/dts/pflash.dtsi b/arch/x86/dts/pflash.dtsi
> @@ -0,0 +1,14 @@
> +/ {
> +     pflash {
> +             compatible = "cfi-flash";
> +             reg = <(0x100000000 - CONFIG_ROM_SIZE) CONFIG_ROM_SIZE>;
> +             bank-width = <1>;
> +     };
> +};

The convention would be to name it flash@<addr> - but in this case the
address varies, so what you have seems fine.

This ties the pflash window to CONFIG_ROM_SIZE, but the two aren't the
same thing - CONFIG_ROM_SIZE is what U-Boot builds itself for, whereas
QEMU's pflash1 window size is the size of the file passed to -pflash.
If a user runs QEMU with a pflash image whose size differs from
CONFIG_ROM_SIZE the reg will be wrong. Please call this out in the
comment, or better, drive it from a dedicated symbol whose name
reflects the pflash size.

Regards,
Simon
