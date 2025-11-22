Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB80CFC538
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 14:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D345483B03;
	Sat, 22 Nov 2025 15:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BHrHIEtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F9E83B0A; Sat, 22 Nov 2025 15:31:51 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A021983AEF
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 15:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b7277324204so503547666b.0
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763821909; x=1764426709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPp1tAPGdmsExdEanTiolvlFLo7+OzYlzoS7FKgoqHA=;
 b=BHrHIEtnGseWSkcoy6OplC9xDoTKImk9fUvcgWN7YJBO4eBPFJJPyNfndS+kChPWCf
 qSsYSuYHFoDvrDCwVeFRcHgc2jFZiV0H8xemVBb/LcO5Olln77Ebp3+W5vljYmM9E9S3
 5Do7qCzp2xWfON+CPyERehP2CHwf0QobEiTME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763821909; x=1764426709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPp1tAPGdmsExdEanTiolvlFLo7+OzYlzoS7FKgoqHA=;
 b=qd+Q5oqdq2lAJiXgB7tLFF/rNhpm6rh7Rezl01LLOJTNZ2ruK5sXOFqOqNZWQkDoFU
 yObjbd1cU/QNG2RDtHqOqxXZUKCBqLd8jvnKluu0QVMQ48NHJDOjIDf7s0KP/iS6cMbg
 eJFuWoawb7lb524iVLnHtVaAsDvZUEDlxLJVDV2PDpxRHu9BJsS0Ec9TI0ElPf5XYYjU
 dgZdKu5MZbT93VL3E5lTD/Vx3FJtx8UNBju0R9jBtG0MqVQLbrIjqpcMm+hK/gAEHw2g
 d7zW3XAv3tOVpiYd/dxtbKdMVWet4LnQpW/3o2jsJoWtPa0gEPeTimtCs2o70R+Se2Qt
 Hlog==
X-Forwarded-Encrypted: i=1;
 AJvYcCURPUGqoo8a3iWGKgS3am3UHP52GV7+eipUwRkJfcv1OwBVTKFUXlJKY32NgE3ukGp29kEQILE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8WUylQrkBHaHPses+ZI6oW8XczIyrLAtf/7Zo6pDEJK+w6oiW
 2qNXQVwAiJ5LptdeC4A6XgTsPl+UALEdoJrZnBPbw0ma9a1xPUnxNUIPh5fYtsZa/zyuvTW98UJ
 +NpMoROkXqN+lxnaZOxmfZIzeJ7oJcopFeGDLuZz5
X-Gm-Gg: ASbGnctUeKs3nBig7KO8OHbmH75yHp3DlL4LaikxFE7rL6qG80gFYJj6TpSzxZyIbXa
 4Wd0IbZJTi8tJDQivbWoN0AZ1ygfMHdl86B0CmhvPJ3shVHT+4bc5hB9MQE4S6WzNyRCdo6/oLy
 sXiMbpPQU4hdnFgN+HRw/bU2zug4Y3YnjR5SijIggxARRlNOHOh2ycFBBNZJk6KdTNKapyVA4PW
 ptygjWvqZGXKUlsefH5bcSGjL+xgWbBICnqQ6oU7dm5RPNlmWkCqnnh/veDdOeMufWHkw==
X-Google-Smtp-Source: AGHT+IG/E5yR1ENZMelqRgqXknA+hX7lsHuM5s0RkSdkdWDH6UhEAiA4S1tquHlgXkRjJKyGo6ks7HoFG7dbg1Qy8FA=
X-Received: by 2002:a17:906:c10d:b0:b73:78f3:15c1 with SMTP id
 a640c23a62f3a-b767186f2b3mr583984466b.52.1763821908513; Sat, 22 Nov 2025
 06:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
 <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
 <20251121143510.GX2125796@bill-the-cat>
 <CAFLszTiBezzWuBE2qo8iEU8dyyD6ro4x2UrXGnQnfKSYSmTGgg@mail.gmail.com>
 <36b44a71-e98d-4b89-b639-cb1e31f41865@mailbox.org>
 <CAFLszTj_RJuGXriRMpEnf3ZM8Jd4zmSB87KiTdk7umjzfcw4Og@mail.gmail.com>
 <20251121192753.GD2125796@bill-the-cat>
In-Reply-To: <20251121192753.GD2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 22 Nov 2025 07:31:36 -0700
X-Gm-Features: AWmQ_bk8IF-ITVV_86grweXBuDieh5FJsKpWJIDuk6388y7wxYaEdMcmfZmZtV4
Message-ID: <CAFLszTjxRS_471AkuwdAhf97N4SCosuPnutnGPf=MRvcUMVc-w@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Fri, 21 Nov 2025 at 12:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 21, 2025 at 12:09:31PM -0700, Simon Glass wrote:
> > Hi Marek,
> >
> > On Fri, 21 Nov 2025 at 10:53, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 11/21/25 6:35 PM, Simon Glass wrote:
> > >
> > > Hello Simon,
> > >
> > > >> To be made to clk_fixed_rate_ofdata_to_plat_(...) in
> > > >> drivers/clk/clk_fixed_rate.c as it does not currently call
> > > >> dev_has_ofnode(dev).
> > > >
> > > > Ah OK. So the call stack is something like:
> > > >
> > > > dev_read_u32_default()
> > > > dev_ofnode() - returns ofnode_null
> > > > ofnode_read_u32_default()
> > > > ofnode_read_u32_index
> > > > fdt_getprop(NULL, -1, ...)   // guess
> > > >
> > > > And I see that I put assert() in some of the ofnode_read..() functions
> > > > because I don't have tests for passing an invalid ofnode.
> > > >
> > > > So perhaps fdt_offset_ptr_() should check for NULL and return? I
> > > > haven't traced it though.
> > >
> > > In previous patch
> > >
> > > [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value unconditionally
> > >
> > > that approach seems to have been rejected, and these dev_read_*() fixes
> > > were implemented as a replacement.
> >
> > I don't think it was rejected...but I think the commit message should
> > better explain the problem, e.g. using some of the info above.
> >
> > The only choice is whether to add the check unconditionally (which I
> > think is fine for now) or to add a new type of assumption.
>
> Your feedback here does not seem to match up with your feedback in the
> patch in question:
> https://lore.kernel.org/all/CAFLszTg6dF1dmJJDh8-2ZjUf6i9+ZOFvWNSxNRS_PBQ3CDNtHw@mail.gmail.com/#t

Well in my defence the cover letter and that patch didn't give me much
of a clue. No mention of OF_PLATDATA or that there is no actual FDT. I
thought Marek was saying that libfdt no longer accepted negative
offsets!

Regards,
Simon
