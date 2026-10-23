Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20D606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=irDQdL+D;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sxLIeQA7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A00C6606AE;
	Fri, 23 Oct 2026 16:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YBMAXP7xsVVQ; Fri, 23 Oct 2026 16:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBC8F60809
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792772533;
	b=tQ33xEkyqA0B8d+QeHhr4cV3cmsN7ZqlgkS+pO4qS/rRtrU65idde8CG7WK82swVl8Cj
	 LcKKvFJSNpMh+Uxzni6wPGdwgFP36cp74tI/Uenr/rW6FL/WWw4r3tL/ASft8J3vlmkRx
	 R616uynbyy54w2mKDbgvTLUnB696uQwi9H93g/Y+WRpthB5LjwlMmG/L6SvNHD5BdHodi
	 ZhTZCeGR3+WxPjYX9VxbELU5xI0+QxFsi4zOh6GesdOqskbNLVdrVwXbJOH5AlnicWkXI
	 pVZYgkiw4z6jObmErEEVvIYPT0dvO+fWiEOk9HhIh7XS0rHwPWcGQaoNZblVYt5qj7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792772533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:
	 X-Google-Original-Message-ID:Date:From:To:Cc:Subject:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bVIZwCkeACtei6RN0RlwjHbAHJA33n9d36Y8YIQZMVw=;
	b=BOwL7xm+bMZTjtke/O2huGwu5fwVSyLg8UqEmOL9BBJhT0bQO7Ib2Ebwvbc5AEUsqXNH
	 njZsnb33oOyBXt6KJeEHL5dZ0MnWper0r0nQBESvltSYV2xJv71dK/MBLUKV7cwceZxUs
	 zMvk+2u2VJiMYlQsbKlG/8cUAFmtPccM5LJULHjJP7AwYD76pff0eHsQoZ++tZDwOuzpO
	 y2YAfBObOJJlw5tlEgrdv9iGXW4L6j13yKIQkbb0LAn6Y40EskhBrrN5K42WBnkJFTpEA
	 L6akKipk1EAGHZMXCx/NjT4tmGnnJ82GAxIj+yV+y/MfmyU3wE9tgIVEHr1FMks7jzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792772532;
	bh=bVIZwCkeACtei6RN0RlwjHbAHJA33n9d36Y8YIQZMVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irDQdL+DbOkxzrDbRVt7QADmif4R+8N1jnIc3HplFS7Th/ZOTQlKL9n9fYRYitUI1
	 XWI990S/yntl9fUnDKNzJ7gBqhdAH756z5cDSY/zlEZI42fRZev8BmguycoxJwWocZ
	 9AZPGnuMy4J1ZwxaOSDHu7dWEKRDXidJC+Mf0u8kBXX4kEY2QHemTzHZ4h3mvi2EFI
	 Jz0rgwxoaH/pb+rQfP0veEqwj9ix6bfHSarxa7Kcz6ilbDqGz5DTZmDIWSPC77D+1+
	 lYN7/9qOfTGU8Y8OcC8UA7IWRo6c3x0W4Ff2vcxi+Xds7wL2kkY4qg24fXeM/Mrleb
	 Pv777yOvxwgYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBC8F60809;
	Fri, 23 Oct 2026 16:22:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA6A5356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D05E84020C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzED2Dx7fx1e for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 16:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DF7C1401DF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792772531;
 b=P7mXGrQPy9afDZ4KTBPT8i2r3bPn9WwQ2qfv0i5+5lHhCtjI/HpJZILUjcgXXNJIfzqg
 3bixmLLNtan07HKqo0uBtA5YcO0sr1ZKpBQADmXqz+SKb/mG5Lxn5BFLm2NbtRH9epG5a
 YTgQHPQGQqMgAYVh1+mSUCOXR1OvfObco0fVDT9VrOmAPhD/ZdUYl8I0pKHv4eS5/mykd
 oB7nLwmgg5QgJuyrqrDoE+zy81qceCeZFLULsCKN7Z69WsOKR0S/y4qgy5TFhVWvWRJ5I
 ETIiCm82y2F7/fJv86BcZfsyp7cTIA+B0W5Mh8eeX/fziomZhWjRm2nalel0A9EHQZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792772531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=bVIZwCkeACtei6RN0RlwjHbAHJA33n9d36Y8YIQZMVw=;
 b=ZdJNfV2dtFzkFHD+VYBvfEhggmWp6oY1Q8aq4xNdDZfg1aNAGTKa9hiVjn8ZpXGIlDuC
 +Uip5iqPQzuqnsz4AzYHrwBmWaHXjJH0V7Uhdopa1sbvDyzr1BExUAVAr2VKZSzy8WzCh
 TqODBWLCEdGDtGWJ1+3U0JZqCwUSDJU9FM5riUkU6rWvltoNTZUXVqda8vJN/M5AskfEj
 meRuCOOZ7TMvsdPEe3hrG0RO+EHNpekQaT2i5qmx4W5FXaH+vJVAD4DDRf9tOHWLglRt8
 iX2P/QjtqovNFnnRKl3aaTKDGN5VrRGRnR6ZHBq0kn9FWH1tw0LdzlP5OtxBPK5EZJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sxLIeQA7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sxLIeQA7
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF7C1401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:22:10 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so410672f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792772528; x=1793377328;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bVIZwCkeACtei6RN0RlwjHbAHJA33n9d36Y8YIQZMVw=;
 b=sxLIeQA7hIQBRVeyXd1fj9ZqUmQ5goSKr1vWIZgjckKJdGhWfAHqaF2ZyqO2H07SXO
 nJxu9QzkJJ0EU4WlITQXbWnJLqclAUpuLTX/gKUTQxmzNFTMktR3GWqUAJ5+ci/jL9Rl
 i0EB6PQSZp8++KmcEIWhL+VHFn5Mmj4SkSM5RCo2cqMeR8Yzgdmt3za8o+KFmrA+5mIq
 wHF3qmNofuzr6cCCNsIz92RLpyYdi+7Vnk6AckrHVJqRtbRlj0EFp2hXS0bn57vjPBMR
 9gtJDvHrBLF/8C9vsp0StHmbDgxXf4JiYDPjsFRSLMdmI0bt0DZmxWBfjGvb1V5af/Wt
 VxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772528; x=1793377328;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bVIZwCkeACtei6RN0RlwjHbAHJA33n9d36Y8YIQZMVw=;
 b=or85BuEyo4JYZbQc4Atbdra4Ki0B1iHYYTaSL920ETeeYWp6+SzFol5L6GvBzqeYNw
 uGxy6cYdS7ibnNNnEjvnyYc+9Fes8MkT0gi5tFSM2YfQ6xYsSqSTKYX9PN98/LDnHR1Z
 qt3w121zeZEZoXBkvwaY0w7u/Fycy7ii0cADcqujXjt1aWOSrJLRJJOnbDW3jHsWacdV
 iGy3g++MkB5JBsOC/MeSul6MblDLBA96sgwztcCSxr5UEFkd3HBm4ikesBYm8mXm1kTP
 eyukhlWzVefmBHFDMWi3iDKj/nSB2Ut2hsNAPzG1yI5ABKYmXR8ubS4eAdT1iq/SxHKn
 Yj0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVgfMyRip1SKAv+mnJ2rTtLDqOPac4P1DGQEK3nMMQMTZVEWqlg0X4p0Xx9YXsFFJ9oJzWq/c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIzXXZYic4+ZSypo4MP6shngdnjgQigA63+zzkzK1og2EEBFhBz
 HA6LZSTrMnGFEyyee+M/QuqnqRtjxBKGKVaPMMmpkenSmDrC9GScNksv
X-Gm-Gg: AYBFou0d+my/OuyMD7+OngZBE/Xk2JEIH1DsTwq6CaQn80fmy9CLY98EeUFNtQ6klL4
 fr8ZNgqsI6wYeQg8brWmlximhR8BdZCRgIJurrab9R7EyFvCuwhCNaF/QnrFqRU/VSzQpvo7OLZ
 +hW/JBbiI0XOsuYRzmiXdPaSv0L0NKbkoDv6wvqwGpleYFDLkTI3mr9Pa2OMSqacPT38kD4ShuY
 AogaLcYNrI3DBi7bSa6r2T5/yPHLYtPbQCPQL+qeXxh6gJa5EtEf+GvNFNOcy+MVoxGAEgJzMyO
 oiC2pHztaxp44FF50ul9HauDEU72g//LiuMkUxbRFx9F2qHrjfWPgCn7NXlx+9uCGavZJyAug7F
 ChnKNABDICDvncoKjhow+Q7/vVhvM8tN70xRcqupCsMCwHajCIkfK/nkMw3AazMg0hVbl3iByHp
 ho/72jSut9+zayXs7gj1St4B3GviKsIyltt5tZn6tNMmhET6U+G+W4sIivnXY2NXaV6VDP/i6NZ
 bJViRULsB7Trcpl3JNoPQiXAjvi9ibglu4XPEAtsuN6ZCbk2iA7fGJlt7kwRimYVumaG6Ir45S/
 hA1xYRDh/+KokNzqFA94093/zHDmIRCADSB1l7egsj0=
X-Received: by 2002:a05:6000:298d:10b0:48d:ffe7:e883 with SMTP id
 ffacd0b85a97d-48e385a1841mr3299374f8f.46.1792772528048; 
 Fri, 23 Oct 2026 09:22:08 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d40c182sm761781f8f.34.2026.10.23.09.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:22:07 -0700 (PDT)
Message-ID: <6adb89af.a6a2e554.25ef39.2840@mx.google.com>
X-Google-Original-Message-ID: <atuJq7O9mAhr7TOE@Ansuel-XPS.>
Date: Fri, 23 Oct 2026 18:22:03 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v8 2/7] misc: fs_loader: reorganize and split to FS
 loader and FW UCLASS
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-3-ansuelsmth@gmail.com>
 <CAFLszTj+sti-+-O9OjMu3YBiq9X8TwEr_UFYXSxb5efHdRgGAQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTj+sti-+-O9OjMu3YBiq9X8TwEr_UFYXSxb5efHdRgGAQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 09:12:26AM -0400, Simon Glass wrote:
> Hi Christian,
> 
> On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> > misc: fs_loader: reorganize and split to FS loader and FW UCLASS
> >
> > In preparation to the introduction of variant of the FS loader,
> > reorganize and split the driver to generic fw_loader UCLASS and
> > specific fs_loader function. Create a dedicated directory for the loader
> > and move the internal structs and functions to a dedicated header file.
> > While at it also drop some redundant check and rename some variables as we
> > are updating the code for the UCLASS rework.
> > Doc are renamed and updated to a more generic name and for the new UCLASS.
> >
> > This will permit to reuse all the property and logic of FS loader
> > with container that are not exactly a readable filesystem.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >
> >  ...{fs_firmware_loader.rst => firmware_loader.rst} |   6 +-
> >  doc/develop/driver-model/index.rst                 |   2 +-
> >  drivers/misc/Kconfig                               |   8 +
> >  drivers/misc/Makefile                              |   2 +-
> >  drivers/misc/fs_loader.c                           | 328 ---------------------
> >  drivers/misc/fw_loader/Makefile                    |   4 +
> >  drivers/misc/fw_loader/fs_loader.c                 | 176 +++++++++++
> >  drivers/misc/fw_loader/fw_loader-uclass.c          | 188 ++++++++++++
> >  drivers/misc/fw_loader/internal.h                  |  91 ++++++
> >  include/dm/uclass-id.h                             |   2 +-
> >  include/fs_loader.h                                |  47 +--
> >  include/fw_loader.h                                |  19 ++
> >  12 files changed, 494 insertions(+), 379 deletions(-)
> 
> > diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> > @@ -0,0 +1,176 @@
> > +	if (plat->phandlepart.phandle) {
> > +		struct blk_desc *desc;
> > +
> > +		ret = generic_fw_loader_get_phandle_desc(plat, &desc);
> > +		if (!desc)
> > +			debug("%s: No device found\n", __func__);
> 
> generic_fw_loader_get_phandle_desc() only sets *desc on success, so if
> device_get_global_by_ofnode() or blk_get_by_device() fails, 'desc' is
> read uninitialised. Please can you check 'ret' instead, e.g.
> 
>    ret = generic_fw_loader_get_phandle_desc(plat, &desc);
>    if (ret)
>            debug("%s: No device found\n", __func__);
>    else
>            ret = fs_set_blk_dev_with_part(desc,
>                                           plat->phandlepart.partition);
> 

Hi Simon,

isn't the current logic the exact implementation you are suggesting?

But yes I will update with the compacted if-else since it's more readable.

-- 
	Ansuel
