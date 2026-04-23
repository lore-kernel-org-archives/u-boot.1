Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADBDFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E45884105;
	Sat, 25 Apr 2026 18:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t5/6dP8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E184A84109; Sat, 25 Apr 2026 18:40:17 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6340D840CB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so6515734fac.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777135213; cv=none;
 d=google.com; s=arc-20240605;
 b=daomddkm0J9/yiPwiiMO5INdxCT1Bvuaf9pUBIcmM6Phc1FfKmUYSJQ3Y7p693r+jc
 v19itWnw1j2R9v/vEtm4owjZi4ZSTotGgaOSVfQrefoyRGt0faYnMATAdy4trldEhb/I
 3OAfWQfjwnBBXDFHqCN7B7BnYlUzTirqy7kMS68rkMtVYxJQFGhwgy+WF9KVhK6CXmS1
 MzQI1niVWF7vHISw6Rkbyd6xDE2oF20qpYw9YRGsP9kbzrUkPOFgYBoDyrrQua59Mnbt
 GlN3RyFWDNgV/rl09axKzTtr5znIMdPtn4SRDt555pv+Nzi915lZwmS260o3eThsIS9c
 /k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hg4I4aLzzSUK+2Ny/I/KwQv36JUwWymks3Il9haf9Xg=;
 fh=1pqfa4fLOAnWs0aRnppSe1xXirl+0mZpoFceW6lVFfY=;
 b=UK28pL/di8N9zMo3I7rd/vIHoNjuJgrSgRt0cZybCVPrOa0hxs8fuScv3F6lQED9td
 fYSPf2bD0R4OhO0CuzWSnStYIwbN9GgvcjZopSOs4hQ6HZa2eLmIzGIT3K0o8jNyGq/6
 nlQ/Lm1CsipB1QLk4xmi/+8I5opFEIvOv8FBZc/UwYT8KDrIKk1LCJH7MBllzw051j3O
 emPbHjo55UFPDmbOVjzXxPf+vVzs5uZZg2B9/dwWc/fQtPZi50Nv0yaXCrlcOW29M8CT
 iiV4W1zEaIv5yCvaiTTzYeucBd9T52d5ljtYLbMAC7b5JAjTSiMD6o7qsvaNaJPoOYkJ
 QBCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777135213; x=1777740013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hg4I4aLzzSUK+2Ny/I/KwQv36JUwWymks3Il9haf9Xg=;
 b=t5/6dP8apXKOlkahUFn6K+3R5hl9H01+dpavKOWCBNLfgHZH8KSVluUXAmyOGOj4we
 Ffq5UJ6zvlTsE7POmELcJQ0JROK1eSt9KCdhBB/pxabUT/3hrmGmr4W5yt+1/ubAoijd
 m46vYoVdQA1xzFeF9S2ObGZi9L/yvn9oeWbfMAZGBzCBn9Mh5i2Ic36plKmctMwb2Uqm
 Evipt+5YcGTDfspajh7BwPeBRHHfHokyZz3kOpjsWYRj8Uu6uC4wfdnXRx3r6x2/o/1w
 diW9I9tVx2N9ajuj6oTskJ3Et5cocPNsP+JIq+toxptS3bZCLR3S3m7A2oO2m+XiGkEQ
 XO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135213; x=1777740013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hg4I4aLzzSUK+2Ny/I/KwQv36JUwWymks3Il9haf9Xg=;
 b=HlKVb3d92z7eJkw22RIc3UDWMTKHktl0ZRs6jj+y5LMuWKU2gUcW+3I/F1YzwjfD+m
 vlk7MSWMouKG/eeV/zxeoMOghP/eHmZ0Tu9T4eZWlZYfbPODW4dqeUFz0MJEBeg28QPc
 CT28tY7pB6CWU9Zn5KAy/rMaOcJJNlOeNO9jmmwpcKj5kMeoon4VQmOSnWWeZbkrEOSf
 K59jYMaIdV4S9Dn/Z9S+/Xf2+3RW4cS1YWqyuwVpgQXneRQCTC6JXlnlifqSRquchaOP
 4ghPcC/O329tU662DScfM7/TRkIkwGrggIz52qpWnqXEnrXcV4jfBYtrm3TMeDrJQIBO
 ywMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LooK8De1Bt3KB43a3g/3BX4BlskGNmye732ZSvZSnWmdnG0E0DIkVjwD5Rw2+b1REF2Z4EWY=@lists.denx.de
X-Gm-Message-State: AOJu0YzbpIBOJtubsQ8UTPoP5aDCG1XO19SIOO4tPeXhWWpw2+FPac2D
 UiU0c5rAeghdvUC+vkyjHM31WftRjf5ecNDlG6UL8n5Nb2wOjpWUjdpHSIlO+zfaQu/wtD0ZjB7
 /fRoJDT/+vRsPiYmoo4+0mBGUrw6lpDQtndAT3JiDfnwfjqVfc3xm4hM=
X-Gm-Gg: AeBDies/xAoNoqCL1a/Vk4hUIO3za/cuZmGmI7MgaAqaUfonjnnabYFe0ThPX2nWnjR
 6dGsu2eVag17CY3diIyw4Zg9uHgtXHwzyYS9smVc4cQUtYgkfB4hcOkai3yg5I6+uJNSwMpt2Dx
 v6Lhrydm0HIpBNmplvQJML/RZ3bQw+Rw4iyDN7TJY8S6vkickzF6Xi4BmCaKWjwohK/qiZkVo1X
 9/jgo3cczsgTZ7SjK1wUajh9DlKM0DIOYluywI4b53zPWK98Np0YFm5K6s+GQjWR0mWvOSMSKYZ
 K1OcVhyZ6/1sTjMfqmyacoBtHde2fTRdo7HpCvkyUTUlkonbR78VfxLjYxkOFBbiy4CcaZRaPgl
 9DcwMT6c/fPkR//5HgHEpUK0LjJ9OwmGIiWgQ7CioaUxhEjSr5IkE+oCdB7070cSQ04EKs+g7gj
 mwMimkiK0weAR4sOTEfL3JPJVuRp+p98SvIivCNEH+phc0bpkN1li2laeOiiBUDv2i3rrkF3mbE
 aIWjvi7MjLa8mjoPGyLyU/BN9dsQwH+w9mzvXvjR+UXlhRNI16k0uOiqxnBaYbmFOydvYhfiUHl
 aHSwy67KpS1KYF6SHrc/Q/qU++oMGdOYfoH3CcLlyq/UPrNnw/shnQ==
X-Received: by 2002:a53:d005:0:b0:654:2ef4:a5d0 with SMTP id
 956f58d0204a3-6542ef4b01cmr13873284d50.59.1776965198144; Thu, 23 Apr 2026
 10:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <9511039f-3c92-4b4f-b6fd-c13d48867d24@amd.com>
 <CAC_iWjK-nrgc5k6G4PioWb=YoLi5vJojfPLC_=N8_68RAiJNXg@mail.gmail.com>
 <c938e4b7-66a7-4156-b394-1b28c213e14f@amd.com>
In-Reply-To: <c938e4b7-66a7-4156-b394-1b28c213e14f@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Apr 2026 20:26:02 +0300
X-Gm-Features: AQROBzCIEcS9ra3-md8l314u1vJlm7XSjqfagycAv5N1h5R8WtePPlNOxVrJVSQ
Message-ID: <CAC_iWj+8zdF1MG2ZEmgJmF8-ONYDaHAjH3GLDLhutEzhC1fpiw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Michal Simek <michal.simek@amd.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

On Thu, 23 Apr 2026 at 19:06, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 4/23/26 17:28, Ilias Apalodimas wrote:
> > Hi Michal
> >
> >
> >>>    {
> >>>        debug("Monitor len: %08x\n", gd->mon_len);
> >>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> >>> +
> >>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> >>> +             int bank;
> >>> +             phys_size_t total_size = 0;
> >>> +
> >>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> >>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
> >>> +                             gd->ram_top = gd->bi_dram[bank].start +
> >>> +                                             gd->bi_dram[bank].size;
> >>> +                     total_size += gd->bi_dram[bank].size;
> >>
> >> Here you have one problem. If the latest bank is defined with size = 0
> >> then your code won't ignore it and just use it. I think you should check at
> >> least that size is not zero.
> >
> > I don't think this checks belongs here. IIRC the only reason to do
> > that is have some previous stage bootloader, or earlier u-boot code
> > update the zero length with a valid region. We already do similar
> > checks in fdt_fixup_memory_banks(). We should add similar ones to the
> > dram_init_banksize() variants. Most of the board specific functions
> > call fdtdec_setup_memory_banksize() anyway, which I plan to fix as
> > well and get rid of board code that's not needed anymore.
> >
> >>
> >> Obviously size needs to be big enough to fit u-boot itself.
> >
> > Yea that makes sense, I can add a check for this.
> >
> >>
> >> And as I said this is one configuration. Versal Gen 2 code has by default
> >> configuration that it stays in a bank where it runs.
> >> board/amd/versal2/board.c: dram_init()
> >>
> >> Added by commit 3aebac5a759b ("arm64: versal2: Populate DRAM banks before page
> >> table size calculation")
> >> Focus on text variable.
> >>
> >> That's why I can imagine that above code can be extended by one more
> >> configuration to stay inside bank where actually u-boot is now.
> >
> > With having the dram bank in an array we can go an extra step in the
> > future and have a Kconfig option with an int, representing the array
> > position of the bank we want to relocate. That should cover what you
> > ask here?
>
> Position in an array won't help because we have generic configuration which can
> run with different amount of MCs/banks and it is not practical to say which one
> it is. That's why we use bank where u-boot runs before relocation.

Ok, then we'll need to add a Kconfig option for that o nce someone extends it.

>
> Another part which we were handling was actually also dealing with reserved
> memory nodes. Did you test it? I mean configuration where you have more banks
> and the last bank is all reserved. Then U-Boot shouldn't relocate to it. That's
> what it is handled today too.

Apart from some xilinx boards calling get_mem_top() I am not aware of
any core code handling this. The current patch only depends on what
dram_init_banksize() does. But then I don't think dram_init_banksize()
should be responsible for parsing the reserved memory nodes and
adjusting ram top, reloc addresses etc.
What I can change in the patch though is call get_mem_top() instead of
the for loop that adjusts ram_top. That function already takes the
reserved regions into account.

Thanks
/Ilias

> Thanks,
> Michal
