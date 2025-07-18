Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E063BC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 12:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662868362A;
	Fri, 18 Jul 2025 14:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TDcd42Dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091308362C; Fri, 18 Jul 2025 14:03:25 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A576683623
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 14:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 91446A54154;
 Fri, 18 Jul 2025 12:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904E8C4CEEB;
 Fri, 18 Jul 2025 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752840200;
 bh=FilWV8R0JSgzXmNXwP98MBVlw2C/Cd6mg9fXE/EHrdY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TDcd42Dj1YssRANLcP8cj1eOYFsSR1vAUaI/cB10yEM6BBS2XtfCMIe652NbJlRyQ
 A9T6m1QiSQx1GaBvVeC2VIgNa3QiHIc7HxefdrgsGzX1xuvZW7oIJucOnsMTP/+aC6
 Gw5RaQcVPYjstRF709G/Wjhaf5GL36gQJuvzYtfogki7lO7mQvHQhJt8X1YxDYljEM
 TBYOyQCTORrh8qspYxG7NJanCTXc6LT1lSESsqPgASG5CFGLdTsaguvdyztaxjJAtx
 j7fOnFPWWe2xE51h0dgF3zJRgzQ634kTQR+VD3lcpG3C9F0iHMXd2o1FScFA22uxAN
 h42zihc9M7flA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: george chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when
 bootmeth_android provide cmdline
In-Reply-To: <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
Date: Fri, 18 Jul 2025 14:03:17 +0200
Message-ID: <871pqdaepm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi George,

On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com> wrote:

> Hi Mattijs,
>
> Thx for reply.
>
> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:05=EF=
=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>> Hi George,
>>
>> Thank you for the patch.
>>
> ...
>
>>
>> > -     ret =3D env_set("bootargs", cmdline);
>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>>
>> I don't think it can be done this way. bootm_boot_start() is used in the
>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
>>
>
> I got your point. I have 3 ideas come out.
>
> (1) The logic purposely empty the env bootargs, either developer don't use
> env bootargs or those use cases touched bootargs in some early step. And
> then wanna disregard previous u-boot bootmeth operation, and empty bootar=
gs
> for that ongoing bootmeth stage...well that's not congruent behavior; I
> have a gut feeling this is a bug or band-aid anyway, it closed the door f=
or

Simon, is it *intentional* that override the bootargs variable in
commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?

Shouldn't we get the bootargs from the environment, and append cmdline
to the existing bootargs instead ?


> people (potentially abootimg) inject needed boot param between bootmeth
> stage. Perhaps, either clean up bootargs before bootmeth load stage, or a=
dd
> kconfig to check and enable this logic, a better representation.
>
> (2) One more thing, the vendor_boot cmdline is not handle neither in
> original logic nor in url from you provided. So I can say the url one is
> not capable for extended with Android boot img version > 2 since
> vendor_boot cmdline not handled.

What do you mean by the vendor_boot cmdline is not handled?

When parsing the vendor_boot image, we go through
android_vendor_boot_image_v3_v4_parse_hdr()

That function copies the vendor_boot cmdline with:

	data->kcmdline_extra =3D hdr->cmdline;

(to the struct andr_image_data).

Later on, in android_image_get_kernel(), this gets copied to the
bootargs:

	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
		if (*newbootargs) /* If there is something in newbootargs, a space is nee=
ded */
			strcat(newbootargs, " ");
		strcat(newbootargs, img_data.kcmdline_extra);
	}

	env_set("bootargs", newbootargs);

>
> (3) I don't think it is very much different between your mentioned url wi=
th
> my patch. There is nothing advanced, but just existing code logic reuse a=
nd
> that logic handled vendor_cmdline in other path. I prefer code logic reus=
e.

The difference is that in the patch I've linked is that we only change
Android specific boot behaviour. So less risk to impact ChromeOS.

>
> And I believe above are not the important thing....
>
>>
>> Changing this would potentially break ChromeOS boot behaviour so I'd
>> prefer to find another solution.
>>
>> I know that TI has a downstream patch that changes bootmeth_android.c
>> instead:
>>
>>
>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.0=
4-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
>
>
> ...
>
>
>> Would that work for you?
>>
>>
> Well, the one from url also fine with me.
>
> The important thing is here. So as to ease the change with "minimal impac=
t"
> gets in. I can add one extra check to maintain original behavior in case
> people have concern of breakage. Code example as below:
>
> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> + else
>       ret =3D env_set("bootargs", cmdline);
>
> This logic eliminated the concern, but it also limited those potential use
> cases for Android boot header version > 2, unless the newly introduced
> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.

I'm not sure about why this is better, as from what I understand we
handle vendor_boot cmdline properly already.

Can you provide me with a test case or some example commands that show
that vendor_boot cmdline is not handled properly?

>
> Or this one with good extendible.
> + /* Clean up bootargs purposely */
> + if (IS_ENABLED(SOME_FLAG))
> +    env_set("bootargs", "");
> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>
> Either way. I prefer first one and can blindly apply without afford. I
> leave the idea above to people more concern with it. Please let me know
> your decision, I can provide one more revision later.

I'm sorry there is so much back and forth on this series. I hope we can
come to a common agreement and get something merged.

Thanks
Mattijs

>
> Regards,
> George
>
>>
