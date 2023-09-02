Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F5ACA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFF58687F;
	Sat,  2 Sep 2023 02:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vx2ipFlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C87F486703; Sat,  2 Sep 2023 02:09:40 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9160186759
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so4455421e87.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693613375; x=1694218175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8W7gJ9i2zqTg0vCmIIcYq8wluPRSShl6DlKnvve2fT0=;
 b=Vx2ipFlrNWjGrZEkbcmi/NR0PcMoYFxJoDqOG41xQ4PZOMiXsVHG0diLRcmeLEVzW5
 ydycmS51PpQ8lAcjdlabNpt5dRyvYaFN9Ioxhi44zkG77IRGK+rJRa6cwQglqDumH/UF
 RxhhbbdCgUXO54Mzwykb7pyBX5lqoGyLv8m80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613375; x=1694218175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8W7gJ9i2zqTg0vCmIIcYq8wluPRSShl6DlKnvve2fT0=;
 b=coSJfQsaqwqQArMXthbVtfCNB/hZnf/MzWTq2dLMuSqjnwKACy//4adoAbfLKVlvQa
 /VWaMqf+lsmhCDy7u8W1sWWHBQ1HULdX7NYy3o2XZ+vf6oXJAi3M+5rYaFyucSb/NDvp
 igIpAdFXX0RkjZ+aQB4gv8MyyDuJXCMGxGbj+/rleNojGk6/6iTlQvm+3+svNxku1Qsv
 4+c6h5jLP8FABgTUqPde1tZ02LYngY72WIaj/WN6Rk3Y5oYjr0e9R+KJ/BNaUE7V5V1j
 tiyL9lQXbbqvB6KITcTFomldElXBE/cb8813GV1o01GYrQTyujm9tDUkYY2mByh3nUfg
 T8aw==
X-Gm-Message-State: AOJu0YxN9xxLhSbhubp3wOyesTI5PAE6R5i6x4T/7iDoXH0wQeg5RUo1
 eqLSAO74V+CthEOezI58MMJ5frlnXHuYD9k2S+gX0Q==
X-Google-Smtp-Source: AGHT+IGZslH6xfZ1dELuWc5JyB0qXhfX3kepwSnPvHj9+3LOUyB0X/vYNER1pTBNK/1ZbiCDnOQnHgg2Icsk+BOPfeM=
X-Received: by 2002:a05:6512:3a86:b0:4fe:2c6:1d76 with SMTP id
 q6-20020a0565123a8600b004fe02c61d76mr3146575lfu.21.1693613374543; Fri, 01 Sep
 2023 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-7-sjg@chromium.org>
 <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
 <20230824142505.GM3953269@bill-the-cat>
 <4cbffed6-6a07-1a56-bf10-7303e2aff78b@denx.de>
 <20230824151419.GU3953269@bill-the-cat>
 <8091c4f9-a0ce-aa69-098f-2effdb68ffdb@foss.st.com>
In-Reply-To: <8091c4f9-a0ce-aa69-098f-2effdb68ffdb@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 18:09:22 -0600
Message-ID: <CAPnjgZ14AcYs4-kSRTBGfV=68SNHd3t6mN3qt79cteRyPoskMQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Dillon Min <dillon.minfei@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hi,

On Tue, 29 Aug 2023 at 10:29, Patrick DELAUNAY
<patrick.delaunay@foss.st.com> wrote:
>
> Hi Simon,
>
> On 8/24/23 17:14, Tom Rini wrote:
> > On Thu, Aug 24, 2023 at 05:09:07PM +0200, Marek Vasut wrote:
> >> On 8/24/23 16:25, Tom Rini wrote:
> >>> On Thu, Aug 24, 2023 at 05:12:45AM +0200, Marek Vasut wrote:
> >>>> On 8/24/23 05:02, Simon Glass wrote:
> >>>>> A '.stm32' extension is not allowed anymore, so change it.
> >>>> Why?
> >>>>
> >>>> This will likely break a huge amount of scripts, I'm tempted to NAK it
> >>>> unless there is a very good reason.
> >>> This is in the cover letter.  Today, buildman --keep-outputs doesn't
> >>> actually keep the needed for booting outputs from a build for a number
> >>> of platforms.  Simon's response is to stop having a free-form list of
> >>> outputs. With I guess the caveat being ROM-defined names (for example,
> >>> we still keep "MLO" because that is the literal filename TI ROM looks
> >>> for on FAT partitions, on mos of their 32bit platforms).
> >> Why not just place the free-form files into some output/ directory and be
> >> done with it ? Then they can have whatever extension they want, as long as
> >> the output/ directory name is stable.
> > Yes, an alternative here is to just extend the list that's removed in
> > patch 2/6.
> >
>
> The ".stm32" was choosen on output on mkimage to be aligned with:
>
> - all STMicroelectonics documentation  (for example
> https://wiki.st.com/stm32mpu/wiki/STM32_header_for_binary_files)
>
> - the proposed scripts or files, in particular in the YOCTO generated
> flashlayout files.
>
> - this extension list expected by our tools: STM CubeProgrammer
> (https://wiki.st.com/stm32mpu/wiki/STM32CubeProgrammer)
>
> and Signing tools (https://wiki.st.com/stm32mpu/wiki/Signing_tool)
>
>
> So I prefer to kept the ".stm32" extension here:
>
>         filename = "u-boot-spl.stm32"
>
>
> NB: the justification for buildman '-k' option seens not fully relevant here
>
>         because in patch 2/6 you kept not only the ALLOWED extension but
> also some particular files
>
> +                to_copy = ['u-boot*', '*.map', 'MLO', 'SPL',
> +                           'include/autoconf.mk', 'spl/u-boot-spl*']
> +                to_copy += [f'*{ext}' for ext in ALLOWED_EXTS]
>
>
> so all the files "u-boot*" are kept with buildman -k even if it is not a
> allowed extension.
>
>
> I propose to change the patch 1/6 if you are agree
>
> and allow binman to generate the file with same rules than buildman -k
> option in patch 2/6
>
>
> The filename is valid if
>
> - the file is named with the allowed prefix 'u-boot' => 'u-boot*' so
> "u-boot-spl.stm32" is allowed
>
> - the file is with allowed extension =>.bin, .rom, .itb, .img

Yes OK, it seems this won't affect you in any case.

But as Tom says, we are going to try another path...basically just opt
in those files we need.

Regards,
Simon
