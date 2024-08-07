Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B147C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD919886A6;
	Wed,  7 Aug 2024 03:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tlWfnQwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D025F886FD; Wed,  7 Aug 2024 03:22:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57DD882BE
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722993722; x=1723598522; i=xypron.glpk@gmx.de;
 bh=lDA0LqhN+XQhkocEYTEl58ubRCyWC3pUlT3IZce5Bgw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tlWfnQwSsAfOSCXk60Hr2MwjBWSP5NXNeSDejIpKDQJAVRHWnqzzuJYnSj18XAQ6
 KECaMKbxU7mgo0EnoOGeuR7s4eU4yJAni1WRn/4/t4Nt68VH4JPoY8dMD5LFCnd6v
 K676zn/05kilG62NxvU7hhzR/YKqP6o5U7uGUrzu90OcT20yfhz0enSDxvpTweHWU
 WIY5wf0jiItKGWwYwomSugM5mh6YDd2GiNYQFpRD5ksfp8AMpPyjkjqExtMp1ryUR
 0Kn/TRj867uw2UgohtnQCwNOAzIhAtkBOhFygN3W6ikC2fCNjJRt8ZUZQeU6TcTf5
 HHXhx0FkQ+5Wyu60Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1sZrTY0RRe-000LxI; Wed, 07
 Aug 2024 03:22:02 +0200
Message-ID: <d3d2206e-0044-456e-bed5-07ec8d74f8cf@gmx.de>
Date: Wed, 7 Aug 2024 03:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/39] efi: Show the vendor in helloworld
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-31-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-31-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c2FzX6d4VDK/WePt820rZ0hvcH6yUbXSECP/LFKEidgLKHYRDra
 tQljMwzR2MKghC38Fl2RGaEfvLK2vnmdQDrmr7KPhVrS8pzhpfp1rz9ZZvVKVsJb4aa1Mf1
 3U/kys6GPi66yVCmm6RvQThfKPB8XKnpXBaLL8aIfIe5J7rJ5eX1e41mYjs+5AKzmk0t07V
 SoIaVfjaM4WFNt8T0zIYA==
UI-OutboundReport: notjunk:1;M01:P0:6wh/BgiHXpc=;L4uIAJs9hmpGOB+55227KsPvSAW
 kmmwozYeyH7obne7Mo8yghv/VzSvPAtrfmAhQJCK7Ezr1LdS7U5MfQIv6p0/PcGETmnZZpH47
 W30fJt5JwLEOdYUl/C9u3mCJF2MroOzyMpIJ1eedNfFjOrbJ0odMFt+8UCbbvLBdNSNfwGany
 +D9RT9rOuoqbUqlxO77qkry6ONPM+y/4ZjDl2HGk1/Kuu4nVSBg8xOPLSnvxmshPVOow/Gb6f
 PWTKgl5X//zUMyyZGadAUUUETQJcKml0ddRlkwP8ld6lxFexfq5ivVg9T2qjTI5RpTioztW6b
 iUxzx2VlYBFM6Dfwsea8CLpQnT7mqpjqcmlBA9IN+wUMbzbGsU5QtB6F6kMGk+ywHjath3cMZ
 SmIozVdiO22L714DzBHxjv9vrzOgAAnxb4/A0uQpddzUQtuOV+rD8NZqtyvDIjiosacySTrF/
 bEpDZUDO4Kt7HqSMoRA2q2xcNkFXuuGcylLk/a4bqlGxFYAM/Ps/xz3IhZBccIQdHpsAPHfeg
 a4ldmrRFw3bXDh39QJ0M3bC/bDGyxebncRe4UaPksldEIg/EOa9sYtZXr+j7NLnxziyYKic3P
 b0SZf2MVDRbAYHULF7mUDagPuEiDCBvHHUwT/WKxkMKj9qmA6eLUO2xNZQwGzKonfIvKBR0C8
 51LIMdVzCH9T75+lH8XwwTqyHybK4HWPqKM/k+u8pEc25Dmc7AE0/h8zgt8Urih+kKjiIyyH3
 VU60r1FeNPPNnqJ8GV4ukmwZnUcUhFel1vuPn+Z5UUYEve25TpGhuWy0XPa1DslYZBtSeI0xy
 PpCHRKepQGmhDGmAcr78Gwwg==
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

On 06.08.24 14:58, Simon Glass wrote:
> Show the vendor name so it is clear that this app has been built by
> U-Boot.

As described in the UEFI specification the system table is provided by
the UEFI firmware to the entry-point of EFI binaries. So on a Laptop you
might see "Xiaomi" or "Huawei" displayed when running through the new
lines. "U-Boot" will only show up when running on U-Boot.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi_loader/helloworld.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index 586177de0c8..f120249126d 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>   			(con_out, u"Missing device path for device handle\r\n");
>   		goto out;
>   	}
> +	con_out->output_string(con_out, u"Vendor: ");

%s/Vendor/Firmware vendor/

Best regards

Heinrich

> +	con_out->output_string(con_out, systab->fw_vendor);
> +	con_out->output_string(con_out, u"\n");
>   	con_out->output_string(con_out, u"Boot device: ");
>   	ret =3D print_device_path(device_path, device_path_to_text);
>   	if (ret !=3D EFI_SUCCESS)

