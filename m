Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F421CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F0680AA6;
	Mon, 28 Sep 2026 22:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1uv81z5_z8Xf; Mon, 28 Sep 2026 22:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 947BD80809
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635373;
	b=UDU99osP+VmPCgfr99kFsjHL+J/hlyYk1ovBj5goZ82+qnBH6+eJcJcV6jvyukExGTGb
	 l+LyERmrUB6A+ZJZh8eBsmXzOw8GBq+tX859e7DAXHQsNWATxVm2w+d3B+vo+gtjaz+HI
	 AzqO/w8SVaekqWMs8QMyzKDmLk4pqaBuPVUt8aHBKyH37ulfv+hHA+9/fPEvHvVvQD1If
	 qtDK7zMDJLGql7OcocwlkrKSBj8P2TJcDCwcG6Cm/0OFErm8F7Qgg6zWq2P2ON2OL017G
	 x9yHNb1IEahUwVBYzM5dUWlxj4axm9mORHcw3V9tqL/vtLW9HH2McNO3+oXaKKJ4bKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qCcM9up40ezgZJO8/C2B3FMSkjzp9oECbGNPInF3Rbg=;
	b=dK81jjZpaWJ0x81D8rO6d30GmCwwtB967bsoi076Yzzu0UJ9c6+7f30uwzfFCmC6Rf0h
	 UsNTa+7s7qugIxIZE28Ro1iBd5zFEuTy2OLO5nAe5HoivXDxvgwcj50YxRmymEBSWHo5U
	 kdEZU6cAtpU5HXSZL0QulXuDSzgfpnVNk706HVc4oBItCntOk7en2rKwk5mEZqCN7FyCF
	 yl+MlnQElNPNb0LVmtBSWeboZLjBJxCSIHntsgravmkghDP8QRn7vC0xXJOLfxayRK7b5
	 21DyX7W3+eu/LnUbwqQs5yQA4RhkXX0P52YD270R0vGftID7XsXAO/MfpTJqG/NtTFQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Rx5t1xB7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635373;
	bh=qCcM9up40ezgZJO8/C2B3FMSkjzp9oECbGNPInF3Rbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqUHRI+Hk5NWQ27ltCtYzoYcLY7nk5heAGBsaCtA6fvdIVp2dDxRGJ8fpI7Y44nKt
	 KtZGIFMyDEjRQL8Sd41ezbq8FmSpfvJTdaDpiD2/wy7bSE5UTBifQBndX5kS3r/7NK
	 bgWVHXwVPAK5s1uQgmGpBX6qPl/AUgjdHswJGzBXqgYQ0AmZ+8JcgZNZOtIZIohJa1
	 K+Ayjvp+D/vpwAT4str/9SVpoJ2nFMtz55CQ5oxxM3A3+5Py1dLoKWJU1ZVAmk/pQM
	 xwFFs3c+x8RiIQdN9/Ehg3+bNULDXj+hYUI7foyooC6qA4TyK5x5ypxmPQI4KO11Bt
	 RPTx6z0jVpBZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 947BD80809;
	Mon, 28 Sep 2026 22:42:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 164C472
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFACC80809
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9H096EpQprw for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:42:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 40204807B8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635371;
 b=Dn3L44M2McLHhAz1oDVYYWRI3i4WVaB9vbt/0DKCwDXfeO+R6G8PKwl7JmDffkEsdyVO
 4tjeH76Q4lYveUpnP2IjhYvkQZYegbah3DmCWsSPgtq2h9+3jBTcIF+nDroCeGxgwdKQu
 x6YorGD36G2KM2y/RXbVWIsNqfbKuPkb6RUyRjScO4R5g75ujeUDsDXcnLGEbZ6IKUT7F
 +zdMP68aVo8E4qjchQa9DNoTVabsuCmBfIJd1CoUQVDjyRupLNMb6gvpOiz+SWsXgz9jx
 Y/qo89F1PH16KAwWYv41U0At6C8ExEaD1oSwsDGh4/eAgkT8tGh6RtRdnsEmYXpDcNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635371;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=qCcM9up40ezgZJO8/C2B3FMSkjzp9oECbGNPInF3Rbg=;
 b=SQFHRUjXHZlKXrJOmdzS5eM4hML89Wa5tlp/1FzT8OSNv6zB/QQueMFUcaUspVu+7myx
 5kVtBI46krZafOGsLfkGm2zFCv/4UNNAqjKxAv+odu5Yog1IYbnfsQbH9wp122bVDG9/U
 dDZTjH3TfGhFm9zdU10yJfG/VXtEf1/Rw6AjAGnlES42qdFjrd07JTZw548SroYrm0WCU
 ZLAOsNa89W7w/Kzx4/F+eB6jSXtHH81TAq59u8Q6aTCqln42DXgh4ey35isYEyK2o2QHu
 lQEt6LEL5oZXzmnvAzRLVy+3JAGOdARhuZx8hp5sGgU8cMUzlTjEblSPuSkc5DiX/Jg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Rx5t1xB7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Rx5t1xB7
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com
 [IPv6:2607:f8b0:4864:3b::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40204807B8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:50 +0000 (UTC)
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc791f087e3so1198850a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635370; cv=none;
 d=google.com; s=arc-20260327;
 b=p/gAQ+NnTkx8zbtJnFR9w/mwkXRlVUetqb+hOyCO5+4Lmcutd5IXMryIeRm1BKpFtN
 nKKI3E1EVRN/XcEUab5zaI1CED4+VLh3KwpJgz/ZKerhEHtV7OfK/arNy/I3gAtRZcyI
 xFW0oyBvTc0w7dwUCwcbJy9UBVvIPZs3s9kQNomGPNx/2rDQ9rIV0bKL034irnWfe/VS
 CUr9u8/BeTjZ+vnr3TUG0Kvglx2xE+YGmwXp3G23Cw5TLIMrSnJ2yRLoJhnC9HRsjWHe
 hMGKA9MzR+mT3rVnSJLuuBji4Z8DsI+oLuxdeF9h9zsWvetJ/MjT389ZYC1mstPZLMMT
 gcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qCcM9up40ezgZJO8/C2B3FMSkjzp9oECbGNPInF3Rbg=;
 fh=goUYNN7KLBIABr7E/r94H7LtEejpD99hqZ8PILuVIt0=;
 b=OM+ITe6pMHQ1d5mIXQomBCb3eonqOibvzomLUYT5oq+Hq5xNyV59I6kKzS5kpkITE+
 nu32tEknYiM6cbHgL/mz4Rw9g7JK3ZlthH4WD2vRcB/pmvQGZG8V3ECSvMB+mAsnpU7Q
 5WqUkQwii92PlmDfi9ID4lDfNswxm+KS1rZPTI/dhJ59v4a2raAmQt0LsvJLtas5rIrS
 hr1ry+d72ofRn4hwt3x3q/eP/W9Rao6d4L4NyWtqmp6r4yEPWCSghmHma1NpNsxjZu1H
 9l3tHNshnc9FcFHU1CHsiikLenkE8bnxF0nyjJ0VOZLbe+AlkCOKfs9usemHagddWXCQ
 Z+rw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635370; x=1791240170;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qCcM9up40ezgZJO8/C2B3FMSkjzp9oECbGNPInF3Rbg=;
 b=Rx5t1xB7UhcaqrOROAmRQEFGqI8uZj6CDUhJZBC5aeFUTh01GXKFWogbxXR+qfeNEn
 Ma6b05PcWLGuaOisF7vC8IUH//N+EO3Vsy8pKUXb9XXUWLMQNSly7sEDYy7ke0KcKWNh
 ppGuXg6m2hZWI6N4lR1Ofx7U/q4NcwJPI+6Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635370; x=1791240170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qCcM9up40ezgZJO8/C2B3FMSkjzp9oECbGNPInF3Rbg=;
 b=cSb1n3dM+KTFfs3JRE1iipGinBDXnM1RmlUEaL6oO/W6CJJbb1Y40Kj7CjWxj6qxkM
 B5WFNI+8VMjCA17RnO+2Zk7mmNVfih8wqW421uiHp2r55Qt65t9gLd3BcxxgrhAGYZKq
 MqVLqkPbxzO/MwK2DfGWDsAfDFd/O/x2L+aaRxe5OB4eRHFkqz5L45qPQUuOHqPoyz9l
 UMHOytu/RqIZPN2Lt9A2Zp1xsSlivHifxGvZrcwzvu1aqee0A+dC8D7kGpmiNH+k47+J
 PWuMk9qv4D4egBIis3QW/J2lfLq0aTYMSZW203oOUMMoeYToyk1nLWL4jqKQsxGhTaTi
 hGaA==
X-Forwarded-Encrypted: i=1;
 AKwUvByu3iUou1959PoASX9pqzArYDI6I5KNE+94l7hrM0xBIV1F/2Qi3rsYkrAWcyGSjloakZWb/4o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lsv2cDKi5Ena+SbIU16gXQ074LEJJBDSratCRjIln2xioM33lZ
 XqWN382G17G4GS+WF2eeYZPtdXV6mgfeJvFIY6DiSWTVtfojP3LWtaYuADgEhx0VUPHKm/3FBCc
 hn14UkBiGmZP7H/aapC7U57GR4Hvm/wfeJxkk0seP
X-Gm-Gg: AYBFou0MFbkWVH4uuBrNkAfOEAiTmj9jdPUXEZYhtxMI2ff0Zznc4Ld72Gjy7g0o3D5
 EP23p6470Vzhoqn0MthUAK5PYfPgRomgfwvtLr+HKMXtSiInpOYsDdaqI+eDi4vAj7oKC0iP2zd
 fVyUhm/3wIoA/YPNi2Fgo4DaW0U0KpEmD2mX+ULwQ/JKTMnG6oQhyKT6BI5jJDOpj5ttHmpAfyV
 3HM3y1ZlIQdCS0N8yRI1fIT6WSNo/sE6fnhVPP6k4QWRiaFfbGe2DwwY2xG9S4jZp/dTpjIFnMV
 4vx8aV8GkgLE5J4Quu19HzSdyi3RnkGHS2UwnM320rBsOq3emVEEgT27cQ==
X-Received: by 2002:a05:6a20:394c:b0:3de:76da:6b9 with SMTP id
 adf61e73a8af0-3de76da0d41mr1916254637.68.1790635370084; Mon, 28 Sep 2026
 15:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-8-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-8-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:44 -0600
X-Gm-Features: AclHuK_TuSJZZ8LGeiQAI2cjpQgUB8piFRjyhNt89xyPx7RSndge4ETKuWNJFe8
Message-ID: <CAFLszTi6vZemWa6ZkxNzzPyUsgM03dXZao1igC30FFmY=EBkXg@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] usb: gadget: fastboot: allow configuring the
 endpoint buffer size
To: sumit.dhami@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com, jbx6244@gmail.com, 
 vandhiadevan.karunamoorthy@oss.qualcomm.com, 
 dario.binacchi@amarulasolutions.com, sjg@chromium.org, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, varadarajan.narayanan@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi Sumit,

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:
> usb: gadget: fastboot: allow configuring the endpoint buffer size
>
> The hard-coded 4096-byte EP_BUFFER_SIZE limits the maximum length of a
> fastboot command received over USB. Long "oem run" commands, such as
> a multi-partition "gpt write", can exceed that and get rejected with
> "buffer overflow".
>
> Make the buffer size configurable via CONFIG_FASTBOOT_EP_BUFFER_SIZE,
> defaulting to 4096. The value must stay a multiple of the endpoint's
> maxpacket size.
>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> drivers/fastboot/Kconfig        | 14 ++++++++++++++
>  drivers/usb/gadget/f_fastboot.c |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)

> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> @@ -49,6 +49,20 @@ config TCP_FUNCTION_FASTBOOT
> +config FASTBOOT_EP_BUFFER_SIZE
> +     hex "Fastboot bulk endpoint buffer size"
> +     default 0x1000

This only affects f_fastboot.c, i.e. the USB gadget, but it appears
for UDP/TCP-only builds too since it sits under 'if FASTBOOT'. Please
can you add 'depends on USB_FUNCTION_FASTBOOT' (or move it next to
that option)?

> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> @@ -49,6 +49,20 @@ config TCP_FUNCTION_FASTBOOT
> +       Must be an integral multiple of the endpoint maxpacket size (64,
> +       512 or 1024 bytes), otherwise transfers break on controllers such
> +       as DWC3.

Since this is now user-settable, it would be better to enforce the
constraint at build time rather than in the help text, e.g. a
BUILD_BUG_ON() or preprocessor check in f_fastboot.c that the value is
a multiple of 1024 (which covers all three cases). What do you think?

> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> @@ -49,6 +49,20 @@ config TCP_FUNCTION_FASTBOOT
> +       A larger value is needed to accept long commands, for example
> +       "oem run" with a large command string.

My understanding is that the fastboot protocol caps commands at 4096
bytes and the standard host tool refuses to send anything longer, so
raising this only helps with hosts that don't enforce that (such as
Snagboot?). Please say so here and in the commit message, so people
don't expect the stock fastboot binary to benefit.

Regards,
Simon
