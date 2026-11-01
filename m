Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nk+mKHfp;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IphYvMpH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71D0C80DBB;
	Sun,  1 Nov 2026 19:20:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoFZl1QAgE0N; Sun,  1 Nov 2026 19:20:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37ED480DAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793560837;
	b=hXJhzg7VLrn7iOqSyZuZt4SPZt9G/9hvRSfemKYfMMLr0zYOiURaGk8nUJaVp4+W8/Xe
	 /0NmQ4RkSluYE3Y1lNVJc7vy9nctN2cCz2zvFV7j/83pS7MR8mxTN/x4DBKYxtokCQlfm
	 iVFpbkSCAm4aBocBWw/2ja6BTbxFn7UOWavdIXd/EjZMIMtCzKp7YN/9UdQyrYjVs391z
	 6HjwZzAAaGLsm8ruiU7CTiM9h/O/qUkCfSX13+SzwUJ/VXVqrtM/TIBLBn3SXrldr1p6X
	 PHoqJAvcjXFLfx8anOiGzOPV1YTGGPBwoeNC29Gu0LJ+9bYmtlvHQKSAgm/4/rlOCWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793560837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J0MDSvU3Ta2iIbF97NutAP7edGN8vRnzN7PCTV5V/Ik=;
	b=VE41H/TTHih7Crkb2TkP7z4HodNStUSO3iL/kto10TGr4tfyhqOL0GPXE0hIkx7Y4yWt
	 iF/V2qF57jIA7E1NIyxp+muVfoLTZaoFtFELFatZnUsew1tyT5R0YrRAVw4C8FzOffVSq
	 mL6DcSEGwC34lvdAVZnf53v6bEdNimFyGAeNyTMSk54AZEcYxF/2dSSsN2x6bByKxPRq8
	 Q1Cxe5r57aREuKM1DDKpO1aq8WTmKlFhYskXkzr3j8cwRbm7rMl5PWtA6CytVgzFo1db9
	 qVDI5whhpjUib8ySxIOiuLUb0vK1blDtwyg47+LpcVKJsdnLgQ9rMx4Vrjah8YL5ehA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IphYvMpH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793560837;
	bh=J0MDSvU3Ta2iIbF97NutAP7edGN8vRnzN7PCTV5V/Ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nk+mKHfpivJ5+hyjRRMQWVAlY02b1zEXsERFrdPygyht1LU3vK1mYWIm4WbwTgjKl
	 0MDJAN0tyYcf/GvKUAlPqsnm+inGlipPEmjU4Vq70jwsi6d249zM8KYVdUrqIe1cSR
	 CwGM6vHICA35c+f0sO2gO442FCIOjFf7Di7qlhPoK4JDBIkCi4DLk8V02CzbwCeeG3
	 yzW/1GLHzlWeOVBpWWpT10JwqG1IjV2Giep8EbAQBL9aMo2dumFc/m+as+tv8hca8X
	 A4xhC4mphz3ENo73wH0rhVjZvm/gnZAazLd6OcbHe575EhczB/Wr7Y4jdKVS24+J+m
	 VPbS1tsGnndZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37ED480DAB;
	Sun,  1 Nov 2026 19:20:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D8C14B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 19:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFD3780DAB
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 19:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndBynf0FqV1K for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 19:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71F4F80DA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793560834;
 b=ENBMPoHCErN7SU9zTtcPTr5C2RJtZAozlp35z1anUEjA0GMRT0JXGkTX78EGClR5aOwB
 cDXHDk0eCKkfIo27c1ZKWjbkKdodyKzq6CJTkegxWwSDGwJ1FHlcq7k8Fm/4xCQ5O4ETY
 gp9acJvbwEhe8sCXybScShCRTc3BYgbl3FtOGynHk19JgCb3OKNk9qXS9+1GF3TnQE3Ys
 mmp8kPXDY7sP/SzTWyA1TIOsDkCLY9lbL/SL6BWXLaXuYnAbJwWsNOzS7ZUWuf1t47Kbt
 pXIPB2nCOpuG0QBYYi8+N8tIf5XlEy3YriAdT7RnmNmGrqYj+MeY6HP3RencJ46bLwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793560834;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=J0MDSvU3Ta2iIbF97NutAP7edGN8vRnzN7PCTV5V/Ik=;
 b=BznBecnm9d51XsHcN9H/7SXlSHtBpX7aHv43WDRjoooR8++GsgPMrtIWNLPsarQ7I+0E
 UJWN5iE2t9nTn83Lw7e9YY02qIRKGjWqYc5QV9BXxOodE0fyEpSw4UNQAzoFor1GRcpUp
 f67XeEqm9aLleDk7Ev46neGMI0mUQJVmlS5VvQjZO0yqiMo2DSodBrjSSPWNPcqgGpFVl
 6IcFiCgQRpkzw715gCzZbBrJ6zLIEc3M+cuc41X29NqHoD3foLZNF3XPvldrX+d1QvzTA
 IlW5U2pXi6viaSS+QgwQRCOIxlw+aplCKiYTAUjZ2ZYFE3Y+KYfAakqJgbMOWEmM1TA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IphYvMpH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IphYvMpH
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71F4F80DA9
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 19:20:32 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so4047234a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 11:20:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793560831; cv=none;
 d=google.com; s=arc-20260327;
 b=g+qq0hF7MHptiYkFEujH2mzAzG/hZ6hlWrN4ZH5xj918E+TZGZ1XO2xwIraxksBGet
 cH0OiZqcAw739NE//C5ewDg5Uf8yJqBRywx/IhA6qOlfhmvRn5LLKAfrdSJGq8XmQ2Li
 Vvdwe3HDGZ7ZfdjwP5PQ71S2yFvgN5SmxKE+3xXi6jjrSnwjCtgL37V8Fk+fJKJRteBs
 /UsGMOTuxe6fxkiGMCY15LxaVqHIRD7BUyisccDY5SI4NjalelQbDQ004jJ8KLN4nhdB
 CpKhFeDSdCVJddBAaUbEeElHkBfDxmBmueMQnhvFqqTe03Dh82WA2s5QUL8S8tyLgI1V
 X1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J0MDSvU3Ta2iIbF97NutAP7edGN8vRnzN7PCTV5V/Ik=;
 fh=he5Y2ESEtJyljeJTBy+SFvtPCDe41kUfpXWzNzSp7tk=;
 b=KydOdb4KhCIALr6lNqWOdnsGntH4oLIAotT2CgmufxokFjzeCMYfvV4mMk4sxmySnn
 SDIPuSV78SYjp2UxHQwAB7FHVv6O8WUIeieS751y8drLpR+fvvFzoUJKwUtyqXaLlTBd
 ePG0jQA4Yce4eyKDAUrodi/M3EnHpBISukNm4Ms1bShY2J5f9Uw8kK6A2F2aWd1iv2ny
 L/WQygeJq9Ddos3mnqKUB8wzg4cIZTjCsCfWqqfrdUgFedgfPMOa9hrLHiGhwm0dKbhz
 5wH4Ep80Bu6Irvxd2+4AYCbjF5rlNHvzdwhhR/iCUcqHYiGIHY4B0NUusfHdn2/W/DMA
 FQQw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793560831; x=1794165631;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J0MDSvU3Ta2iIbF97NutAP7edGN8vRnzN7PCTV5V/Ik=;
 b=IphYvMpHaJPC58gk8EYGNG76Ew4cV/ZRE4jMVDvWALyBvY7+uViO5P9UwHX82Euosi
 ozqn3s3HOiv5sjvTywBglDH6bENHabwHd7W034iIxh0BU5QPJR1YB3OiLv+D0NZAdoPy
 L2/mDGK8+RXEyhoh7LGyqPLLHHchadyReEAHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793560831; x=1794165631;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J0MDSvU3Ta2iIbF97NutAP7edGN8vRnzN7PCTV5V/Ik=;
 b=cdvhj6DxrDdFPPIDu04jJ24YTSe8ilsvl62kevRJ3ki6Fcxphrij1BL8yZy0WIK1g5
 jOUJrM8l8UIHnC/CoMs77y/fQpxaOwKBiEr0GuELLIxCT90Ity95850p7M3bX2lCn4YB
 vZD1tytyjAxIxi6d0FmCui1OszmySs/Kxt6PwGM7EcWfK/a+Jjh/NQoNE58Us9XT1UTg
 3ARF08OE7Uw+OiwEVLMe57fP9iLfT/oqwXkAe376ut1Tb8SnbKhLxIQFlHFkBltavOjR
 Rn1aD5oLeOLLhBEbZak/gwryJir0SWXNHTjxkGbrWjsrL/e83o14MDz/i2KiGXCTfn1M
 Whxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzur0Bd8OG6Ofn+zq4BTyMFpSkd5srpU8T2otBioc2gUy3HM6jf1o7Utqv1zGTzkf6rC4OfyCw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/VddHdhGRsq0AtDM5/0P4iMpMIbrbu5VUiP7LM7eV3qUENWwf3
 HEHgnRu2uYAGkpw81KWvMAxrYzgDVdYgv+vdsnXlx2awM+NkGfaCuLFKqrxvBXIt/mYxJOj0f8c
 FHno8SnhFNqz4lpn2rzupaCIUrIJ4H9vVmlYZmdMm
X-Gm-Gg: AYBFou0pMyLMYX1ZGfLIVUqUlZorF5IV1cgA1QSst55kytYsL3H6trBoZedBYRSZPQT
 CkCoZzwNRIDyPOKqjE9+j0im9I9J6QRseWEkW7S4+mjhKtWj+OTu5BG/WqEN6QBHmvZc0fKBMDw
 jw7T1wDoHBB9LT+iaJiB1gZUCzA9wfxw2NfSmLLb90GjbqO8xpK50v05UE+1onuvGrG2X+CXWpa
 6bvT12Zlxj4i9H53asY0TH/xkCUgfo5kQ+dqy9H5PkgGEnYTMlFs5lbWtNXPXDKpuGi/smFFbhO
 Rp24KJL8oYB+1SAZ10gYzyFmFrHFp89Twy+DHyTdCwsEHNadGiJMDLMojULvJLvZLcwc+zVk0yF
 qzOpAerF5PDdDsZis0LX0HDZWTlw+jPvAtjOciOpwrIP7XYaxptwHuUDTOjOVIRZJXMTBduu8XF
 VZzyZ6+bQXSnsubF32MbE=
X-Received: by 2002:a05:6402:1d51:b0:6ab:7700:9371 with SMTP id
 4fb4d7f45d1cf-6b4d468b63cmr5388048a12.25.1793560830938; Sun, 01 Nov 2026
 11:20:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <CAFLszThDcdt14Chi=UeO0i-gpzUvXMQR1Dd8c1ZVVk6Xgtvidg@mail.gmail.com>
 <20261019181943.GD720525@bill-the-cat>
 <CAFLszTgb2oQ0ffsZqcsTtD78ObQRJDFvC4awtAGozAMWrdMKiA@mail.gmail.com>
 <20261031141225.GM3309461@bill-the-cat>
In-Reply-To: <20261031141225.GM3309461@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 19:20:17 +0000
X-Gm-Features: AclHuK-0s2pMBT3vfA81phtg_03MOqRmv_aTXJsemGiaW1JAWo4oIYcZ4bz-ieg
Message-ID: <CAFLszTg7oERVvfm=Enqb+_1MGQsfoee71L4S-=BogYXS1VLvyQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Sat, 31 Oct 2026 at 08:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 31, 2026 at 08:54:54AM +0000, Simon Glass wrote:
> > Hi,
> >
> > On Mon, 19 Oct 2026 at 19:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 19, 2026 at 08:57:41AM -0400, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > But then we would need to provide the whole device tree, yes? I t=
hink
> > > > > this ends up being a tricky case because we're on QEMU for this. =
We're
> > > > > just checking the signatures on later loaded FIT images. Maybe th=
e
> > > > > series that adds SPL to QEMU could be helpful here, since we do h=
ave a
> > > > > normal path there for applying an overlay to a device tree, I wou=
ld
> > > > > swear...
> > > >
> > > > Agreed, a whole DT is the wrong direction here: U-Boot cannot know
> > > > QEMU's runtime shape (memory, CPUs, devices from -device) so it mus=
t
> > > > keep using QEMU's DT at runtime.
> > > >
> > > > The merge code in patch 1 is already doing the right thing in
> > > > principle: take a small built-in DT that only carries the signature
> > > > nodes and merge it into QEMU's live DT. The remaining gap is just t=
hat
> > > > OF_OMIT_DTB=3Dy means no built-in DT ever reaches the binary, so th=
e
> > > > merge is a no-op by default.
> > > >
> > > > So I think the fix is to arrange for a tiny signature-only DT (e.g.
> > > > generated by binman from the keys, like the normal vboot flow) to b=
e
> > > > embedded when FIT_SIGNATURE is on, and leave OF_HAS_PRIOR_STAGE alo=
ne.
> > > > An overlay fragment would work equally well and is probably cleaner=
,
> > > > since the intent really is 'apply these extra nodes on top of what =
the
> > > > prior stage gave us'. A test under test/py/tests covering the merge=
,
> > > > perhaps using sandbox or the SPL-on-QEMU path, would catch future
> > > > regressions where the merge silently early-exits again.
> > >
> > > So as I kinda thought, we're in a funny spot here, because it's QEMU.
> > > And so yes, going the overlay fragment path sounds like the right way
> > > forward because that also should match what real hardware would look
> > > like (we're given the tree by some prior stage and need to augment it=
).
> > > We might need a little re-tweaking of the Kconfig logic (some new fla=
g
> > > to say we need to build overlays, and not fall back to "and now we tr=
y
> > > and build a dtb for the board") is probably required.
> > >
> > > > I can't help mention (again) that this would all be a lot simpler w=
ith:
> > > >
> > > > https://patchew.org/QEMU/20250405191352.2597585-1-sjg@chromium.org/
> > > >
> > > > ...if we were able to explain how U-Boot's use of the devicetree
> > > > includes configuration information.
> > >https://patchew.org/QEMU/20210926183410.256484-1-sjg@chromium.org/
> > > And I can't help mention (again) how unhelpful it is to bring up idea=
s
> > > that were rejected for good reason.
> >
> > This prompted me to take another look at the thread from 5 years ago
> > [1] - it's been a long time! The objection in the end was basically
> > this:
> >
> > 'My take is that this is u-boot doing weird custom things with the DTB
> > that aren't "describe the hardware". You should be able to boot u-boot
> > by putting those custom DTB extra things in a separate blob and having
> > u-boot combine that with the actual DTB when it starts.'
> >
> > So this series is responding to that. I have heard a similar opinion
> > from a few others too, but that doesn't mean it is correct, or even
> > then, that projects should not try to accomodate each other's
> > differences. At bottom it comes back to the 'just describe the
> > hardware and refuse everything else' thing which comes up from time to
> > time, but that is not how U-Boot works. For good reason!
> >
> > Perhaps more bindings in dt-schema would help? I see that bootph is
> > pretty common in Linux now. Would adding verified boot's public-key
> > schema to dt-schema would make sense?
> >
> > One point raised in that thread was that allowing users to modify the
> > FDT using the QEMU cmdline is a recipe for breakages and user
> > confusion. That seems like a reasonable concern to me, although of
> > course in practice it isn't any different from having U-Boot do the
> > merge.
>
> I wish that when you're told No, you would accept that and move on, and
> stop bringing up or just implementing stuff that's been rejected. U-Boot
> doesn't "need" something when you immediately follow up and note that
> the problem can be solved in a way that doesn't change upstream, either.
> Looking at that thread again, yes, you're wrong. My current reaction is
> that if you had gone with adding overlay support, which you explicitly
> call out not doing, maybe that would have been accepted and would have
> solved this problem.

I don=E2=80=99t think the thread supports that. Peter=E2=80=99s objection w=
as not to
the format but to QEMU merging anything guest-specific into its DT. He
asked for the guest to do the combining instead. An overlay option
would have been the same thing, since the merge in my patch was
libfdt=E2=80=99s overlay_apply_node()

This series performs the combining in U-Boot, albeit with the
OF_OMIT_DTB problem, which should be soluble.

Regards,
Simon
