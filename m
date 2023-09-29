Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF48BE81810
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 12:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCE686EAC;
	Fri, 29 Sep 2023 14:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mLJT4PXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7767786EAC; Fri, 29 Sep 2023 14:13:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4224C86583
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 14:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695989571; x=1696594371; i=xypron.glpk@gmx.de;
 bh=8yMmAtQpIngl50K8LPQoPoZPT3bgr2Yf2me/WTnu2Bo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mLJT4PXqdWhH2HdBS2zJidARtPKlIL6HV+oMpxQbutL9L/ZCx0ePwUAMVe/ovbm4QCcuwj/Ve10
 Qm+Fn49sx/i2/DNZ0/78TQDpvOsqQOg/rgZwNSh5lL2TZlzw2TzFJYb+YYqcOIcomobQ8no47aj16
 UkmXK3eFTzCgRlGSvzTY34V0nX3NS5KXQ2NQvxzW52RmtvT06Gu3X1oQ4Ig+6QAsE5eA3HiGUmIHz
 PKrqXl5TALnSkTEpl2I2dWdrrVRQWcpvxJHMse4Y5VUxJHymScFWYmUlu+MWpZswhfP4WV0MtfYSo
 JtLmk0dUEMbFsAzYsD0W0GJnhoAkoUHea5hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1rRnad0YTg-00ooZ4; Fri, 29
 Sep 2023 14:12:51 +0200
Message-ID: <9bd80497-906f-47af-9d63-c631c04b484b@gmx.de>
Date: Fri, 29 Sep 2023 14:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Chanho Park <chanho61.park@samsung.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
 <20230929115649.GH305624@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230929115649.GH305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eH4cLpVqHiB88tdF7WAvLpgOHntP7zmymHvoyVV9EoQazatO++k
 78Es/t4JLknaOZI695/RSs5hvY8tDXdDYOTDVPqwluW5qXnYHQYNrlNO0lBVVwAKRQWsdgr
 Qgqop3BS1fwJPP98zKdy/9KEYA2ZsN+RpZp6SHnuN25/LjHy48PKoItM3tTh4UdfO2/Y3y0
 REZx2YJmUyimaqVkBy72A==
UI-OutboundReport: notjunk:1;M01:P0:SXXlFFQ4zLY=;GZHsfk6ONSBpQAFbgPjSWfg4mv/
 cRFxpX3QQBpMF2OH5bVdEgOLfmz7wDcdwc3q87TkxIZ6wSykEO/35rBPjP3RCUrjT+Gj4oUD7
 jXYFAJJZa4PPR8aVDBdzlgWJn5GCK5r3QnqLX6deN6Jko+uiFn45C33/0glgvo/EgaZcqFuvT
 4nbUF23KLJ4cJKIl+fMV/8bxyIluMZTdrz+v+/LxGxE/NL6ydT9eLfxMwjrfr45jcun7/7SKR
 LFiySd/o932HDLs8+HJZjEEcPil+2Ig9pO3MABI4h69en01PCyY23lctVea9tuPxvZw9kweoV
 9WjO1K/1bgrExp8qgqfFGgSa0zUMw2XxbSlqDKjtUKvJHECNyd7C+3TGpZjLBzE0HFKIHa+IV
 wL6IC3jhCkjueSq1JPd94ktsxAib/1a52PJK913VdYL6ndz84//KC4PcXfBNdB9sHswPZxY0u
 45AsbQZJtGDuqh1VrWRdEurhyJBzn9x26dEBPclceCU74rUw+ZrqP77ddTHeZwEhTCDc53TOg
 4BlJ5sHmfCzR3Q1afs8SxSGA4pESM+2kdCJX936pQ+bU6MWgLBfaezDp4lBjx8ZEoEztDlbWr
 ePnFkRvoCrsyy80PxT6sdgEdZpoaNHNuHu/i85BXLCmb4k+tOTz+XHajcLoCRzDC7wLHjudc6
 TwKeVegmxMTohruNP0p2dVn4cGJX9dDmxOtyYJcdx97yX8FHWSFYWm83cOI2FN+u35Kpcp4ba
 U3T88d+P7YWji/TjgAlldDXyw0aomHd1q0GFluj+SfG2BNU+nMmalfbgKmRyI2nKsMHwAnZkp
 Wsu2e5PWY5ndgLNZV+x/ElSr50j5sD83CVP9fPWW7+cVeWqyH+29fZE37o+2W4GYnyL4KkOAr
 XBjAMSFvluaoRrRjByCCXMQc+2RcMlC7Tghieex0yJjwawEXu04zcgKhbFsU3QL04utE6a54s
 WN/B0jyDPw4H1ze3XUnd0OWTuQQ=
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

On 29.09.23 13:56, Tom Rini wrote:
> On Fri, Sep 29, 2023 at 02:57:42AM +0200, Heinrich Schuchardt wrote:
>> On 9/27/23 23:44, Jonas Karlman wrote:
>>> spl_board_prepare_for_boot() is not called before jumping/invoking atf=
,
>>> optee, opensbi or linux images.
>>>
>>> Jump to image at the end of board_init_r() to fix this.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> This patch have dependencies on the following patches:
>>>
>>> spl: add __noreturn attribute to spl_invoke_opensbi function
>>> https://patchwork.ozlabs.org/patch/1827057/
>>>
>>> spl: add __noreturn attribute to spl_invoke_atf function
>>> https://patchwork.ozlabs.org/patch/1831366/
>>>
>>> spl: Drop the switch() statement for OS selection
>>> from the "spl: Preparation for Universal Payload" series
>>> https://patchwork.ozlabs.org/patch/1839731/
>>> ---
>>>    common/spl/spl.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/common/spl/spl.c b/common/spl/spl.c
>>> index f7608f14e365..79c39820262a 100644
>>> --- a/common/spl/spl.c
>>> +++ b/common/spl/spl.c
>>> @@ -647,6 +647,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>>>    		BOOT_DEVICE_NONE,
>>>    		BOOT_DEVICE_NONE,
>>>    	};
>>> +	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
>>> +	jump_to_image_t jump_to_image =3D &jump_to_image_no_args;
>>>    	struct spl_image_info spl_image;
>>>    	int ret, os;
>>>
>>> @@ -735,20 +737,20 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>>>    	} else if (CONFIG_IS_ENABLED(ATF) && os =3D=3D IH_OS_ARM_TRUSTED_F=
IRMWARE) {
>>>    		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
>>>    		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
>>> -		spl_invoke_atf(&spl_image);
>>> +		jump_to_image =3D &spl_invoke_atf;
>>>    	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os =3D=3D IH_OS_TEE) =
{
>>>    		debug("Jumping to U-Boot via OP-TEE\n");
>>>    		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
>>> -		jump_to_image_optee(&spl_image);
>>> +		jump_to_image =3D &jump_to_image_optee;
>>>    	} else if (CONFIG_IS_ENABLED(OPENSBI) && os =3D=3D IH_OS_OPENSBI) =
{
>>>    		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
>>> -		spl_invoke_opensbi(&spl_image);
>>> +		jump_to_image =3D &spl_invoke_opensbi;
>>>    	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os =3D=3D IH_OS_LINUX) {
>>>    		debug("Jumping to Linux\n");
>>>    		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
>>>    			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
>>>    		spl_board_prepare_for_linux();
>>> -		jump_to_image_linux(&spl_image);
>>> +		jump_to_image =3D &jump_to_image_linux;
>>>    	} else {
>>>    		debug("Unsupported OS image.. Jumping nevertheless..\n");
>>>    	}
>>> @@ -788,7 +790,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>>>    	}
>>>
>>>    	spl_board_prepare_for_boot();
>>> -	jump_to_image_no_args(&spl_image);
>>> +	jump_to_image(&spl_image);
>>>    }
>>>
>>>    /*
>>
>> In SPL we are fighting for every byte of binary size.
>>
>> What is the impact of this change on the code size?
>>
>> I would expect that your increasing it; especially if only one of the
>> CONFIG_OPTIONS is enabled.
>>
>> If so, NAK to this patch despite all elegance.
>
> We aren't _that_ strict, no.  And a very quick peek shows that this
> seems fine overall.  Since you raised the question I'll do a quick
> world build but socfpga_agilex_vab (as a config I had size change
> results for in front of me for something else) shrank by 4 bytes with
> just the prerequsites and this patch applied.
>

Shrinking the size sounds great. Thanks for measuring.

Best regards

Heinrich
