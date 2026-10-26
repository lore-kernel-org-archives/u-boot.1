Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CdJMDN9V;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pn9Dptyz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A5ED80DD6;
	Mon, 26 Oct 2026 16:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KEGEJ6LlViZo; Mon, 26 Oct 2026 16:14:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A42880CF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031254;
	b=LZE26JyqymhG2XIXJ4EaJaO0KJwGLzILrNGq8lKcmqZpvfqnjmGfQsZv4FKPXRYOSg4h
	 Pjbjk1YZvXaFZwy5OhH1Et5cV5eArSZpi8jpKJi0AaJSwslX2ewDLcG38OBreczsG7EbP
	 XByRZjz0k/9eTf247CLyk0mW0y+cZRLM0tkLXCXuia40vUSGVPyIhZLBt6UE2YaoSpAJN
	 wSHLlLwlnsHVrJQxJ14W3rF2WkINfQiPLENm8mTTbRD6IKSx6/5Nud+jKRmvHsbhpHXxL
	 0F1ZLQ4ZHydeXrpQR+mFyIqbSk1XYAFZrTZQhUR+erFGb+BI+PvAkpr9wAGGNiasVtA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9UEKPNtc3+zVhbCYdMwHmVOWm5pt+a5lIZ0KpPVMPSI=;
	b=jcO2FIuJm+eRZe+pofpqWqmHuvaiJeAZKSIDrfzSnRsroZmkEmNt1SQkUUf605o7IYWB
	 jZhG4T6EhhBBw2I6N/ogCgOmTk5DW5JpSLfFtEi77Ou0LsCkK35ilX77u5OFGK6x7i9xq
	 Fcrca02GZ2n5T1NEKQ26Tn+oyjQlzDdAu2mdgYsbxFEXJ3QLvWxsv7VH6Jtbpa+pS+0bm
	 wECprMmZ7ix4efoc3jP5TFyhiBMEGear1f4r+ur6ZD/XmISuNuAsoRuByqOYuTWNspy+L
	 aSPwoUbnKoDR2VUWfFsWRpUtPYbsOFm6XdfMj33r/b+JPQybS0RQrHVk9qa6HdD7jIA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031254;
	bh=9UEKPNtc3+zVhbCYdMwHmVOWm5pt+a5lIZ0KpPVMPSI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CdJMDN9VuO2NeBsprIQaiiRKajOLswOvMK+5wNdCINNY8yKkJo/B3tyWJNnwNyAh+
	 RDrZqane4rs57RAi+3FVhRMg4RnLXzoEn7bVLuM5vH2mdMRGxqx14CSoNS9YNmMRqE
	 wlowoFa27HmiCJfR0H3/GBqTXSYonJ6IP5+ZrIwHyxBhkqljF4rZVSdEetFSq8tW84
	 Q/0XRerjPtP+/Gu1WSakpMlNwPSFWOUJ/WAUxnkrCe2YF6Q2ZtxwghI/CIX6dV36rR
	 r1RHFadtfN0FkrKk/F3NcsW9T7JcD1UXdVohZPtV/8sy3yvUYAY2yNODMQjDRAfy/D
	 GtdAZdlcGh+Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A42880CF0;
	Mon, 26 Oct 2026 16:14:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79BCC235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FBB860612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bvn_PGbipZRE for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B103E605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031251;
 b=F3RTodvfmbpWpPMlIQPOtcGn4Jim4aAB4batPxQdLU2aIrvguCQi7QWY8OFTQaVqKdYa
 94Lc4A/vWf24uLWRByVPe6TEX59U8pFaXyBwcR4OHOXubln1lURC1XlrLgGxtWC9zp7N8
 4w7wopdzoWl/8mukGBFu7XmZo/DnSC8asrsGZk+gscqiqtih39Dv3L+UW0BPVdjDgGKAl
 KxvJ55/LqvGbdrJoA4jE+bEVM5ZHjN7nBdPOrzDyfTxn1xM6AJCRT/lti8WzenMQ20lF/
 qdhxZZkyn2l4+Yee/dvl/YuO5Yi06N4F5QOf0ip4Zggdn0kblYhB0t46P5oO0pXag0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031251;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=9UEKPNtc3+zVhbCYdMwHmVOWm5pt+a5lIZ0KpPVMPSI=;
 b=Ka7bXtMstOrD9vAnUZ0jhftKSl+m8E1Jbi3zUJrqBPSQXGBfoeQ5zgvcBV1Ub92v4n6W
 QG1PB6E0TIT8WPehS9MuOZaXQRqpo8E3xSiav4wG4w0zm4FvSuf8X8sELGlUmPSi4x+ab
 w6X0FK98EDwK0MqHuU+z6pB/7FL9cROLSieMvU8L2OK3U0PzJd+YUaxMUQ3XbtMn5Fm4I
 7ojTUc8QGzqN8fw/hbAXHyapUc5k+FTd8uIcNJgbsqRlvgz5yB8QjPeC6+THSDmE0gP5I
 Lwdkw6F5gJvDqb48YWygbFNlG55eZZSWmayF+xhvK57BNLvdAMgY+szuPEnNSKoSaLA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Pn9Dptyz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Pn9Dptyz
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B103E605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:11 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso1523588a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031251; cv=none;
 d=google.com; s=arc-20260327;
 b=OeGO7tq6IwVp1yx7IKVWFWsN2QFdBqLelKHWUZ70ON858xlMLJHLsPi6vR39XVG6eV
 V69Qaz34zBAt+2d4sDaq4T3r64u1wuVHmzqIZoCYxbXMsf7f0DQtuFSFNhfj/zWXGTLr
 +FeBsetn2utQ4jjFSs+WXrbU82W86S2t4uerBfJ32X/COKj6ckQ1RkU4gIznTdZCator
 IVhkmKPmHF5gzF2fGc+zwIsoMaReDU9izYsu4qoCjr3F7Uvfhyx3fsAit7UShx12Geyu
 UL7TYazWwHDNnjnfuRw2ZZLoA6/BJKWeKt8lCbbhb4q7/zCywGEQdUUeQ18E8vOokxIW
 T44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9UEKPNtc3+zVhbCYdMwHmVOWm5pt+a5lIZ0KpPVMPSI=;
 fh=w9Ta6e6IxL2RIAn+g0BgirO0Um8SelF/7OsBxsfUm8A=;
 b=OttrGomfktY1Iw1M7uklqKpxJFQlub0n7IkyPsbztagSQXTBEYjCuCfH+NmsfDSMxD
 tQSrXAz0rRT/lPPfSzbtgDHrqbK0+e685imPkONp87vsXTPlkyl3bynS0yt6AnhmaLPY
 wClSoVDh2EWO4f3gXre25BCdfD4kneDbj3mF79B71DGTNf82SG50188FEaegLOcAS6ha
 ltyBqh0gdtgmkvBLxQS9IyLXHJMdJz0k7G7p/2SeWAFLo2JsWCZ019tCJCkZd6q0/WnN
 Dz89AVCK6NAouOEt4aJ/ce/VEziH929Su8UsywJiXJkDE4ttEZ1qZyPnlux0bwmwHGXk
 7UWw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031251; x=1793636051;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9UEKPNtc3+zVhbCYdMwHmVOWm5pt+a5lIZ0KpPVMPSI=;
 b=Pn9Dptyz9D21L/Vdu2FZYYnwHN9tIrEFI/G0EQW7C+fFgvnbbg/QQOf/WkY1jWJP+H
 RU6sRJDukRsy4ThmRgh9oQohQ6D98INteIvTkL8WBCmiVfOWiOus+U1OYcnM1ULcQDTn
 cJOzuQ+1gGgxFoHtYGxp91pPiTwACbw+LLRKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031251; x=1793636051;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9UEKPNtc3+zVhbCYdMwHmVOWm5pt+a5lIZ0KpPVMPSI=;
 b=xvBWMZcIN8JpGbayimFoC4pdCGF3k4Bq/kOa64RNlAeTT57wqc1vAeJJq3LvxTOXwr
 lBMKbz9egzkHP0+Qh2zWaikmETUKYIPeNUjaLQ7Gj/maObIt9XxvcbASlaoa89U1z1qN
 xRxvOk5B1KZCRHuQnZkbnACUa0MPMAJua2pmR+4R20ywsku3QMEEKs7ZLCjqYqGTqbvo
 H2ytlkFbo9yLoPs4bCN6yVN7Wte4DXrhyp9bWCAgHgTxuuCe2otNFhi7tDWmJRFf8he+
 rvpA6lDPwFEKG9cYpzAqO+qYERlWwr8G06wWYbj/6Gf2xm2ipMNLCJJ8dZutj7AKTMvx
 wGDQ==
X-Gm-Message-State: AFq9FYJ21gy1pDDNg0KLc1qFxHVyVdkVpW82IP+TPS0RbXDq6+Ro8hds
 AMVp+MdsBiUoxUVR3badgxBjklF1I5f125riMlxfPEZ2xZKeIHO2IpctgOS1uF/dWEmTamTVpkh
 rFdH83aqaFrkPH57jZJbB3KIvQ1PsGd57dzmHsi1G
X-Gm-Gg: AYBFou1PyGYfGfUDqqVP+JG2qswI7n3k0A0Ua17YTXSfrmpF5Y3d/vZMlx1Y5IMjkbd
 V4mDYVAUOVKowqoCWJzCarNn5RTm+vgOacT/ijEOFS/CQNtpgvkM9rKTU+Tr2yJ9cfc+U32UNxu
 dU14ifEgBqKxcimXoA65SryPQ4tW5Kc/UmqC+azUXsCIAap5eOJ6CITisnNIm7lnwN1nguyPc6p
 kC81QUXbQERuDD+RjKRAjEbq73nlXpOVY67gBAVq/s/ZqdFqzPvjTJVE6QF5l9f5onhvKONPeZ9
 S3/XnWSNRHUW1S2dhwdza58ssR5WyKTjx2R8hhbv3nSEpPYtlUQ4cEblSsXQ+P8jyLjLlE6V3Og
 Yk6doDn2C/UU3aKF/IiVCy5IyVUsq0X9PSKg=
X-Received: by 2002:a17:90b:502:b0:3ad:eb38:9778 with SMTP id
 98e67ed59e1d1-3adeb38a086mr3942122a91.48.1793031250700; Mon, 26 Oct 2026
 09:14:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 11:14:06 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 15:51:42 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <597b6a3fca1bfa60e227b9a4f4c5ff555226b469.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
 <597b6a3fca1bfa60e227b9a4f4c5ff555226b469.1793020986.git.hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 11:14:06 -0500
X-Gm-Features: AclHuK_vn8tgr8ME_Zhh4VM-l5VEYyxGnhsyQ0CIF9dVzOn0rpORRC7j-311Gm8
Message-ID: <CAFLszThVKfLeQDweXNnoFDXmmpbZWbi1AvQCCNBt5e=yRR2qSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bootstd: Export the script bootflow execution
 handler
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He,

On 2026-10-26T14:02:15, He Yong <hyyoxhk@163.com> wrote:
> bootstd: Export the script bootflow execution handler
>
> Make script_boot() available as bootmeth_script_boot() so another
> bootmeth can reuse the device environment setup and script execution
> without duplicating the filesystem script bootmeth's handler.
>
> Signed-off-by: He Yong <hyyoxhk@163.com>
>
>  boot/bootmeth_script.c |  4 ++--
>  include/bootmeth.h     | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)

> diff --git a/include/bootmeth.h b/include/bootmeth.h
> @@ -425,4 +425,16 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
> + * Set the device and partition environment variables and execute the script
> + * stored in the bootflow buffer.
> + *
> + * @dev: Bootmeth device
> + * @bflow: Bootflow containing the script image
> + * @return 0 on success, or a error code

Please can you use 'Return:' here (the kernel-doc form used by most of
this file) and change 'a error code' to '-ve on error'.

It would be worth listing the bootflow fields this uses, since a new
caller needs to know them: bflow->buf for the script, bflow->subdir
for the 'prefix' variable, and bflow->blk and bflow->part for
devtype/devnum/distro_bootpart. Patch 3 sets bflow->subdir to an empty
string just to satisfy this, so it is easy to miss.

Regards,
Simon
