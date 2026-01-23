Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02ED74EC2
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 13:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF3783B21;
	Fri, 23 Jan 2026 14:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YmCEL3Fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E654183B82; Fri, 23 Jan 2026 14:01:44 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C2B83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 14:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79420190633so20820937b3.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 05:01:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769173300; cv=none;
 d=google.com; s=arc-20240605;
 b=F21msdOEBpujVEMeSOhbEavKlVxiWW4GykwMVLnSbySzJCAwX54WtLMEfvvgA9SVuX
 eRKp4Vgl/xqN8uz/sHb2MQ8PwPjAtDf5BGJRttVxwo/IeJFsMiWCh2NU4w0c417wqFac
 wIVDY7mqqcXwSNmBY2LvIw9t1P2sSrpcBRC87PqplmocRRPazIdUPEnHxvydwz3D++9I
 BWydLpNpd6xiutCEiB9NgIrSmK9O7lEyVrGWoUZuQYZElwk7QfUjmSQ460DS6A2AmDgj
 np3WHSLo9T5yrB/vV3ITOtaxudRwQFK76RMWTXi55rYsnqatM5mBoNcuY2MdXXQQABbs
 thxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DqEsxoi4UCVFpIt5p19t9e1sobjuKLGSqLA0efA7kPE=;
 fh=VBuFGIskrY1b+y09un0Xcpv8WJId8l6a/B0avbDe9rg=;
 b=FoxsJpHg8NtfX6YlcgQnWzAA6+oL/T9xw/vHq7qZ0p8mtDVIkagF9QybKoB1um1rep
 sFW1ecukJ8FA1d3nF1GgMVDcpDzY8qym/4hXxKbc3qB7b/RcrM2hdh9Uppp444yHuUAO
 LP7XBxZn0GcEGznFKhONzJ7Zcvjb3MJeDip+rNBALm7yXsscsDLnyVe0Sfm7murv0QXm
 yH1hcoKfLGiOjTYYeL6jiTg7+Y4AOdwusp3qGzwVw9U75vurS1VoFIDmDOQb73WkmDX+
 TWLisThWfrf/Ar+yhWjw3IxMkYd+nMwZemc/BjwdM+tBqpHbO4VDQZ7yMqCRCyXak5zW
 FW1A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769173300; x=1769778100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DqEsxoi4UCVFpIt5p19t9e1sobjuKLGSqLA0efA7kPE=;
 b=YmCEL3Frz3TnACYZ8t1x0CcneECql9k7txm/o+Lpa/Z5v9fNBF+hapjLeEUGN6izLK
 jMypw2njTGw7E5JkgkiCbO1kZ95xpxjSx9UYN/7ITyAxyuYC8bcydBOdS+Q26l/8LazM
 XZJ2qwSf/Rz5abrGeEzRrAWKvyh0Ygxu6A4tt0cvjc8dNKXvFF3q2cakQ0zrt1FSI8dN
 9CxYMIvgItXOgTFBJReFK3r1pdJc4FzccqRsJZICnU33FkSooRlj/OHnCSpQaLTr6N2h
 ZRJ0AB5niq4yp5yal/1AyEUP/aGq6hDOvSBxZZmxvUDP3DZ0rUghNglOCkrjXJSjeWr+
 6Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769173300; x=1769778100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqEsxoi4UCVFpIt5p19t9e1sobjuKLGSqLA0efA7kPE=;
 b=CFXR67xQF+h1gRXpzpUkXuB4UY2Ieky73fVxp3NB/Gvc/arGtJTwO8LtOB2E7T1cw+
 ekUt6L13jw6o04vjf84oR9f8xVIHNW3UQVjaYFBrjnRoFGDHZEWWlRfppvMI/LXNFM+3
 jCf82Tr035ZZLVhEcEI6UABxmXYxxdfZZKOiJcEVSOgqSVtcwSfcys/44nhTL4MJrlfQ
 2QkaeU5ucQHiWwb++e2DPXL0OAPYnHf5vub/UwHBXzZkowXUI4J4aF8ENd2Yw1624D2Q
 MRfFbkGEmQyHMLS9GY4McaOIgm7jBhCInE16PZUF5og+G7FVwn5YUg/NIM4y3gYIu5xQ
 DK3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO5qlOyBnSN6URF07BwbuYA6eZ+c1YvokynqA0mcXIEkM/l1bc+98KrgrL6q/BPsdpyr/1BIE=@lists.denx.de
X-Gm-Message-State: AOJu0YzWzmHMgOY/4hmiwtLmRCSAbz6KMSxc3fUee8LyGGJujtpUuWnF
 5sZP/d6Y9qeWZmlHtymcQG9f7Cb8CV7KndPnrMBYhqjchgsQyiUHqNQcqDt4j3kJCC6JTG4jgeE
 frI2r0uhwwsMM6UiKVsET5kO0cC/CKv9QnAeRqoi7Dg==
X-Gm-Gg: AZuq6aL3fLBy/ltt0IYaG9oM0loq2lKiuDlahuD2F+JUVhFstEOebGJM0yiGELIseOK
 E/Gg0TBeQxjfGcdU+Ar+gryG/LpeGo3Or0TW/q3/J912hyqXopjMAVdkfeu7OiCOb6fY7oI3hAs
 ob3tJuarE0kFYglMkPAXDaNi0QJb5S/QfRawqYZZuhKfL/zHbsJ0B8jivZ+4m0txKr/vkwrYici
 rj2d+ZPZZWBOpU/w6FNboZIcocrxF6fYtl10quVnQdxl9bsOdweWYIQ2JYPlQ2PKWbFimjOjYvP
 FJYBZAEC6BJmnj8DwqWbYQZY8nGG3clypiomI0Fl3WKbLIqR2k8PRG2ijFiZLrXZGbgClv28yye
 y4duVT/N2p38yddMh7X+U8daOiRPzyYwdu1+NfWfhg9WrQlBHGhuRG7xEoppWkXD8iHu3smmNZK
 VCegWfgOQAZ/HAovluSuphXvpQus7D5z+9kv2Nh/xMuo9GBCUi+P1KqE+gwn9Ln6Zj/VRFpH7hm
 rxpU0ulGOK4ZcJtxO8nm8DTE72MJe249AdTl3Xun7LFrwhGtlMy7HVIGh6JAxHO2aDd5RbwvShZ
 9hxfFGoBs/R7T8Yf2Rf70YZXExwPmOM=
X-Received: by 2002:a05:690c:ec6:b0:792:7371:63ab with SMTP id
 00721157ae682-7943993b81cmr20746027b3.20.1769173299544; Fri, 23 Jan 2026
 05:01:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
 <6b91098b-8072-4691-b2b4-a41ecf6879e2@amd.com>
 <CAC_iWjLBZz1m+9o1PJJegEPE6SGfNvbAe_JuAUrrFTCE=ydOjw@mail.gmail.com>
 <2de4c7cb-4d74-4f8e-a14a-1f09ad880b80@amd.com>
In-Reply-To: <2de4c7cb-4d74-4f8e-a14a-1f09ad880b80@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Jan 2026 15:01:03 +0200
X-Gm-Features: AZwV_QgSdtXXuIxN9DnjS5cvfHoq7FIy11PEg-tsJoLxIXe73DhnEXS2w3eo11Q
Message-ID: <CAC_iWjJy=77AVuPUyaJzxgQyGtkkcNcrEQsknLwU0r8e35absA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, git@amd.com,
 Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Fri, 23 Jan 2026 at 10:22, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 1/23/26 08:40, Ilias Apalodimas wrote:
> > On Thu, 22 Jan 2026 at 14:32, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> Hi,
> >>
> >> On 1/22/26 13:18, Ilias Apalodimas wrote:
> >>> Hi Michal,
> >>>
> >>> [...]
> >>>
> >>>>
> >>>>    config EFI_RT_VOLATILE_STORE
> >>>>           bool "Allow variable runtime services in volatile storage (e.g RAM)"
> >>>> -       depends on EFI_VARIABLE_FILE_STORE
> >>>> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> >>>
> >>> Will this work on nands as well? They got a  much shrter lifetime that
> >>> spi flashes.
> >>
> >> I don't think this is valid argument here. Users have options to decide where to
> >> put them. The same argument can be used for u-boot variables saved in NAND.
> >> Obviously I can update Kconfig option with saying that you should be careful
> >> about it but it is user choice.
> >
> > Yes I think that's a good idea.
> >
> >>
> >>>
> >>>>           help
> >>>>             When EFI variables are stored on file we don't allow SetVariableRT,
> >>>>             since the OS doesn't know how to write that file. At the same time
> >>>
> >>> I am not sure we need to allow this for now. At least not until we've
> >>> talked to the efitool maintainers and make sure they will accept
> >>> another 'special' case.
> >>
> >> Not a problem for me to disable it for now.
> >>
> >>>
> >>> The problem with allowing this is that if people enable it, boot a
> >>> linux and do a setvariable, it will return a success. But none of the
> >>> variables will be preserved after a reboot unless someone manually
> >>> updates the serial flash contents. In theory, we can preserve the
> >>> driver  model and the spi drivers in EFI runtime services and allow
> >>> 'proper' setvariable at runtime.
> >>
> >> Wasn't this the same case for file based one? I mean u-boot had it but efi
> >>
> >> Yours efivar patch was merged Jun 23, 2025
> >> But this symbol was introduce in U-Boot April 18, 2024.
> >
> > Yes but the patches were sent a long time ago in efivar. If you look
> > at the original PR date it was a lot eariler [0]. It just took a long
> > time to discuss and merge.
> > Apart from that the case for file stored variables is by itself pretty
> > unique and convincing the maintainers to accept the patch had some
> > basis. I don't know if they want the same workaround for spi flashes.
>
> Correct June, 2024
> https://github.com/rhboot/efivar/pull/267
>
>
> >>
> >>
> >>> However, I think this is not very useful. Having an unprotected to
> >>> store authenticated EFI variables, is dangerous. Someone can erase the
> >>> SPI flash and efectively disable secure boot. Due to that, I prefer
> >>> the current file based approach for EFI variables -- which doesn't
> >>> store/restore authenticated EFI variables (and which this patch
> >>> implements). The obvious downside is that enable setvariable at
> >>> runtime is tricky once again....
> >>
> >> Isn't the same happening with file store too?
> >>
> >>   From implementation perspective it should be the same as file based. Obviously
> >> efivar part is missing.
> >
> > Yes. However, that commit included instructions on how to set runtime
> > variables with dd, so people could use it until the efivar changes
> > were merged.
>
> I don't think it is going to be problem too.
>
> What about?
> dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
>     of=/tmp/vars skip=4 bs=1
> flashcp /tmp/vars /dev/mtdX

If you manage to test this then yes, please include it on the commit
message and in the future we can add it to the documentation

>
> >
> >>
> >>>
> >>> [...]
> >>>
> >>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> >>>> index be670a8e7c25..feab212b245b 100644
> >>>> --- a/lib/efi_loader/efi_variable.c
> >>>> +++ b/lib/efi_loader/efi_variable.c
> >>>> @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >>>>                   ret = EFI_SUCCESS;
> >>>>
> >>>>           /*
> >>>> -        * Write non-volatile EFI variables to file
> >>>> +        * Write non-volatile EFI variables to file or SPI Flash
> >>>>            * TODO: check if a value change has occured to avoid superfluous writes
> >>>>            */
> >>>>           if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> >>>> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> >>>> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> >>>
> >>> Do we need the ifdefery here? efi_variable.o is basically compiled
> >>> whenever we have the variables managed by the non-secure world and
> >>> this function will exist either with a file back storage or a SPI
> >>> flash
> >>
> >> It can be reverted and return EFI_NOT_READY for EFI_VARIABLE_NO_STORE.
> >
> > Yes I *thinkk* that will look cleaner.
>
> ok.

Thanks
/Ilias
>
> Thanks,
> Michal
