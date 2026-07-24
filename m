Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A687C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 13:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 287C5406F1;
	Fri, 24 Jul 2026 13:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9m3xKdeNCpQ; Fri, 24 Jul 2026 13:45:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A31340B20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784900702;
	bh=e9YdFSadc2DDexNjXldumZknh72ujlAb0nWDp/bT1Uo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c1bdfq996ObKI9hlm4H+mccZL3PRQlEbYGJtngMHVampPf3hHsKQN76y0cEJtwr15
	 Vy9CcUrSc3GKLye0TxKKpom2S2/VmBXcejosq7j3bHq0COGlamhV+0w5TBsA60W/kH
	 90W2ybADmX7tmpsfpwZdz4mNeIMCX/NWleBVeVcKeyZVUDypeioMYhMZWWJpTGbJAB
	 y/zN3q1+VIvhnaPWpaYpV2PU/Qlun7tH/u1xr/Ty7GQVnGOYYeIG08tuWNBoB8I3Gk
	 Mef6Ll23pSj7VbriFet9rh9vDJ1lVSiVEB+ASHVoPFbIByMaYBKH6vBXMlfG0RhdW2
	 KST6rnRx88CUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A31340B20;
	Fri, 24 Jul 2026 13:45:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DFA73B1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7CC660B17
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uY2KfFOBtBO2 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 13:45:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 91A6660B53
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91A6660B53
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91A6660B53
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 13:44:59 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so81951966b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 06:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900697; cv=none;
 d=google.com; s=arc-20260327;
 b=T11zCQ83TxLuDdWlG7MhY9xORnnPo1zEJplvUx9d3SX49ShXoLlOLzxF0EfIXJDUON
 Kp9f+Ip2boRJxEy3H3SDilDT+jG4l+sCdOrbLxZ0yjqOlKns+zexDhUpMUg44YgClk1C
 /+cZkoI1JbIMuaNZpBGfx0ULGPBuPBk99Zs1A9mRsMNYyg7r2SO14MijOcb08qP/4l5b
 yakEP0sDqEcBeyitz9qIzdJyk6NKHg9cXa/UNsEUG9Z7iKnng0bqCUL+QVWRnD7dNs4p
 0HCef84tWoGRSlYZGRrEJaigKk4YM4BVh2DueOOavuArJb7ZO2OEkq8cRAkFnaxbnpda
 JoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e9YdFSadc2DDexNjXldumZknh72ujlAb0nWDp/bT1Uo=;
 fh=KDAfHXCyADuMJT+VtijSnNgl/6ncU0Z38jXC4GOT1Ro=;
 b=dANCBp320Tk3ngsNj2ESi9RfBf8I+aAJvOmMLfC1ycWKAwu/o2M9eVzzXms7VdMeIG
 Pp2iPRdV6TJDvw4bVgsCJ5nIMx8Xu1N8xD80Lvcdxd0Ig4O8VicX3uq0vk0hFW0XxlMn
 OjF75R2XWLhk04lqHM/IXQ0mm5oNMf6Iid6+U6BlHoO4Mjh4R+VLPLG2YwPT44wOvzuA
 vi07hQBNLItiSG9KHuy50vI5ot6G6VKDnYO2X8CzE4/4YlbL2afkBF1f/iT1VP7Pbepm
 GDfaWnrdTaaK0aqWVCZLlZWL6hO0mKKuAnFfgSqfNVbilQ/flMBYeFi+zQGV/ypPMUk0
 etaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784900697; x=1785505497;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e9YdFSadc2DDexNjXldumZknh72ujlAb0nWDp/bT1Uo=;
 b=FfrBMJ+jRayPpejdinpMQ6Fa+X01Ud1bhe35MI3JQYDVo2WV8pkGV8pN2ZLCAprzyi
 ILLopxGcV5k4aR1ku8gwGaZjeIgwhqmC5ryKZdaGg7gAvfraK3R0N0Tv/OGdzmi6qBjc
 8f0YYiIjw2SD5u72unWiAjZ+T//tqDGGTJJow6E6r7/cynpX7fqnncHl7/xI88GPk+ik
 Pbb/3pOpVNLEJg+FH2c8StPRah3HJZkbYIBTRi7b7NpQoSE2MEs8L7io/h1SV5jOZshO
 PfbBq4ehJ4KQKcIpurIsl+8KdOu6+o9Sd3y1JTdE41v0feLs0Ythuncu8s8rZqb4tLkG
 cUiw==
X-Gm-Message-State: AOJu0YzQJKS5cVDQiG3/07tbIsYemyMeL+Iuh/DBVkFSOZMbzCQE8QxZ
 HmEgZvFGbxA2ixo2PFqmQh5tHMydqm+DsID+jfaoIoTDEdPrKWxGYE4FbYr3X9xf8uuT1U367HZ
 TemA29gSB7cndJ5QXhV+pSnetCxJJyhM2hAuKAIYwSw==
X-Gm-Gg: AR+sD10vATxLtncboTfc4qDxWvz9JUmzoPIxE/FzWTx4ZjPfWEk+/BR84OiVsCkLoqI
 Nuqz4ubTo8xHFmeHdBu8/tOU02/S1st5DC0SR06oksIDqw26jkvWQBXp/xhLHR+LcQ+bLRSwymc
 0IHf9WfN2E6irkt+sSY7HmFHtWRs+bG0OiYEPb5LxeKBmfZjSa7rFKe/OZv3k8lYLQXNazbtmUp
 XUHxU3jXpAJLpv0QJ/RobJVzXNQpOUGqs0mKdGRsz21htKNE79tn9ZmuL89nQ==
X-Received: by 2002:a17:907:8e95:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c1f1338698dmr32842366b.6.1784900697343; Fri, 24 Jul 2026
 06:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
 <baf04b5d-ef0a-4c58-a796-d09edd6c84b7@kwiboo.se>
 <CAKTNdwEQx6SfKgD=RbbznVgLuMLA5P1UbJ3b+KR4j4L4GyCfoA@mail.gmail.com>
 <b8908639-94e7-4538-8a40-d40d00dc57e6@kwiboo.se>
 <CAKTNdwF68AZT6FHSzPCXKy9QBE16eO-AB+0Ggs9oZXicOSp4_Q@mail.gmail.com>
 <e4bcf339-6ced-4f4d-88dd-b033abc431b6@kwiboo.se>
In-Reply-To: <e4bcf339-6ced-4f4d-88dd-b033abc431b6@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 24 Jul 2026 17:44:46 +0400
X-Gm-Features: AUfX_mwfnpmcaj2uZTP10ygoeVEXv0_fGyp8TN0gbvnOow5y0bAlDbGQZiFM3kI
Message-ID: <CAKTNdwGUEsz+cWQ8guc7UtLssAWRa_jro_+AinSsm0V9P+w55g@mail.gmail.com>
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784900697; x=1785505497;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e9YdFSadc2DDexNjXldumZknh72ujlAb0nWDp/bT1Uo=;
 b=fGryn9zq/8dLfBQvEk0ouF7JczUe8K6qIsqY1A7fVGXQ1dMN95tCY1hQ7ADQMXR0OX
 pJCOL4TBc3MQ+gk2D4o9HN+7gPu1HYtYHnM5dwHedeGsyT7hJP+F2nmLtu9Wv6AnOI0R
 ZJ5JAhHkgNuvv3ABlDtbluD719QUsEM9JPUzQuH7PBS423Io5z6p2z92ovPws7TfEbP6
 Lwp/T0qvciRN9yDamPzDgMMHnJ/0XUP7hLv7FYXsu26KO7qnw6Dm4dKAf37+0MZAvT/f
 UTH6lYR2QSELU8vnyGBr4A+EfiZ/suyDqhprzKKSHSzY5y8H2hXyBQdOag4VxbooaQz/
 V1oA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=fGryn9zq
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 24, 2026 at 4:30=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 7/24/2026 11:48 AM, Alexey Charkov wrote:
> > On Wed, Jun 10, 2026 at 2:06=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se>=
 wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 6/9/2026 8:26 PM, Alexey Charkov wrote:
> >>> Hi Jonas,
> >>>
> >>> On Tue, Jun 9, 2026 at 9:54=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se=
> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On 6/9/2026 6:52 PM, Alexey Charkov wrote:
> >>>>> Modern Rockchip SoCs such as RK3576 require ATF to be running to pr=
ovide
> >>>>> firmware services to the OS. To enable booting Linux in Falcon mode=
 on
> >>>>> such SoCs, add binman support for generation of FIT images containi=
ng
> >>>>> appropriately split ATF raw binaries (as is currently done by binma=
n for
> >>>>> U-boot proper images), externally preprocessed DTB and a Linux kern=
el.
> >>>>>
> >>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>>> ---
> >>>>>  Makefile                           |   2 +
> >>>>>  arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++=
++++++++++++
> >>>>>  tools/binman/etype/falcon_fdt.py   |  26 +++++++++
> >>>>>  tools/binman/etype/linux_kernel.py |  22 ++++++++
> >>>>>  4 files changed, 159 insertions(+)
> >>>>>
> >>>>> diff --git a/Makefile b/Makefile
> >>>>> index 4e5c1dd6a1c4..844e5adb7b31 100644
> >>>>> --- a/Makefile
> >>>>> +++ b/Makefile
> >>>>> @@ -1690,6 +1690,8 @@ cmd_binman =3D $(srctree)/tools/binman/binman=
 $(if $(BINMAN_DEBUG),-D) \
> >>>>>               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> >>>>>               -a atf-bl1-path=3D${BL1} \
> >>>>>               -a atf-bl31-path=3D${BL31} \
> >>>>> +             -a linux-kernel-path=3D${LINUX_KERNEL} \
> >>>>> +             -a falcon-fdt-path=3D${FALCON_FDT} \
> >>>>>               -a tee-os-path=3D${TEE} \
> >>>>>               -a ti-dm-path=3D${TI_DM} \
> >>>>>               -a opensbi-path=3D${OPENSBI} \
> >>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockc=
hip-u-boot.dtsi
> >>>>> index 4ba6a87e78ab..866a6ab654ca 100644
> >>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> >>>>> @@ -161,6 +161,96 @@
> >>>>>                       };
> >>>>>               };
> >>>>>       };
> >>>>> +
> >>>>> +#ifdef CONFIG_SPL_OS_BOOT
> >>>>> +     fit_falcon_template: template-falcon {
> >>>>
> >>>> Not sure it is possible, but this looks to add lots of duplicated
> >>>> content. Could we try to re-use more, e.g. is it possible to extract
> >>>> @atf-SEQ, and I also think we may want to support loading of TEE-OS?
> >>>
> >>> Makes sense, will try to refactor a bit to reduce duplication.
> >>>
> >>>>> +             type =3D "fit";
> >>>>> +             description =3D "FIT image for Falcon Linux with bl31=
 (TF-A)";
> >>>>> +             #address-cells =3D <1>;
> >>>>> +             fit,fdt-list-val =3D "u-boot";
> >>>>> +             fit,external-offset =3D <CONFIG_FIT_EXTERNAL_OFFSET>;
> >>>>> +             fit,align =3D <512>;
> >>>>> +
> >>>>> +             images {
> >>>>> +                     @atf-SEQ {
> >>>>> +                             fit,operation =3D "split-elf";
> >>>>> +                             description =3D "ARM Trusted Firmware=
";
> >>>>> +                             type =3D "firmware";
> >>>>> +                             arch =3D FIT_ARCH;
> >>>>> +                             os =3D "arm-trusted-firmware";
> >>>>> +                             compression =3D "none";
> >>>>> +                             fit,load;
> >>>>> +                             fit,entry;
> >>>>> +                             fit,data;
> >>>>> +
> >>>>> +                             atf-bl31 {
> >>>>> +                             };
> >>>>> +#ifdef FIT_HASH_ALGO
> >>>>> +                             hash {
> >>>>> +                                     algo =3D FIT_HASH_ALGO;
> >>>>> +                             };
> >>>>> +#endif
> >>>>> +                     };
> >>>>> +
> >>>>> +                     kernel {
> >>>>> +                             description =3D "Linux kernel";
> >>>>> +                             type =3D "kernel";
> >>>>> +                             arch =3D FIT_ARCH;
> >>>>> +                             os =3D "linux";
> >>>>> +                             compression =3D "none";
> >>>>> +                             load =3D <0x48000000>;
> >>>>> +                             entry =3D <0x48000000>;
> >>>>
> >>>> We should not hard-code these here, they seem to be RK3576 specific.
> >>>
> >>> Fair enough. Should probably come from configs.
> >>>
> >>>>> +
> >>>>> +                             linux-kernel {
> >>>>> +                             };
> >>>>> +#ifdef FIT_HASH_ALGO
> >>>>> +                             hash {
> >>>>> +                                     algo =3D FIT_HASH_ALGO;
> >>>>> +                             };
> >>>>> +#endif
> >>>>> +                     };
> >>>>> +
> >>>>> +                     fdt-1 {
> >>>>> +                             description =3D "falcon-fdt";
> >>>>> +                             type =3D "flat_dt";
> >>>>> +                             arch =3D FIT_ARCH;
> >>>>> +                             compression =3D "none";
> >>>>> +                             load =3D <0x52000000>;
> >>>>
> >>>> Same here.
> >>>
> >>> Ack
> >>>
> >>>>> +
> >>>>> +                             falcon-fdt {
> >>>>> +                             };
> >>>>
> >>>> If I am not mistaken we can already inject an external DT to be used=
 as
> >>>> control fdt during U-Boot build using EXT_DTB env, maybe it is bette=
r to
> >>>> use that instead of passing in a new FDT?
> >>>>
> >>>> We probably also want to use @fdt-SEQ and @config-SEQ to be able to
> >>>> dynamically load a config based on e.g. board_fit_config_name_match(=
)
> >>>> that some boards already use to select config/fdt for U-Boot proper.
> >>>
> >>> Indeed, that would be quite interesting to have to make it all less
> >>> hardcoded. Does board_fit_config_name_match() also work in SPL?
> >>
> >> Yes, that is where I know it is currently being used for Rockchip on
> >> such boards, e.g. rk3566-zero3 and similar.
> >>
> >> spl_load_simple_fit()
> >> - spl_simple_fit_parse()
> >>    - fit_find_config_node()
> >>       - board_fit_config_name_match()
> >>
> >> And in U-Boot proper the board model/variant is mostly used to set
> >> correct fdtfile env var so that correct FDT can be loaded from e.g.
> >> fdtdir when doing pxe_utils booting.
> >>
> >>>
> >>>>> +#ifdef FIT_HASH_ALGO
> >>>>> +                             hash {
> >>>>> +                                     algo =3D FIT_HASH_ALGO;
> >>>>> +                             };
> >>>>> +#endif
> >>>>> +                     };
> >>>>> +             };
> >>>>> +
> >>>>> +             configurations {
> >>>>> +                     default =3D "config-1";
> >>>>> +                     @config-SEQ {
> >>>>> +                             description =3D "RK3576 Falcon Linux =
via ATF";
> >>>>
> >>>> This is rockchip-u-boot.dtsi, drop RK3576 specific parts :-)
> >>>
> >>> RK3576 is the whole world to me! :-D
> >>>
> >>> Will do, thanks for pointing out
> >>>
> >>>>> +                             fit,firmware =3D "atf-1", "kernel";
> >>>>> +                             fit,loadables;
> >>>>> +                             fdt =3D "fdt-SEQ";
> >>>>> +#ifdef FIT_HASH_ALGO
> >>>>> +                             hash {
> >>>>> +                                     algo =3D FIT_HASH_ALGO;
> >>>>> +                             };
> >>>>> +#endif
> >>>>> +                     };
> >>>>> +             };
> >>>>> +     };
> >>>>> +
> >>>>> +     falcon-fit {
> >>>>> +             filename =3D "u-boot-rockchip-falcon.itb";
> >>>>
> >>>> Do we need to export this file? the old .itb-file is exported becaus=
e
> >>>> some distro build scripts or flash instructions still use the older
> >>>> files instead of the preferred u-boot-rockchip.bin.
> >>>
> >>> Yes, this is the file you would actually flash onto, say, dedicated
> >>> UFS LUN to preserve Linux-to-U-boot fallback path.
> >>>
> >>> I'm currently overwriting my main U-boot by `rockusb write-file 16384
> >>> u-boot-rockchip-falcon.itb` but in a normally working setup one
> >>> wouldn't want to do that, so a pre-packed image with the SPL and the
> >>> rest is less helpful in Falcon mode. The combo of
> >>> `idbloader.img`+`u-boot-rockchip-falcon.itb` is what I believe should
> >>> be used, with the former going to W-LU-A and the latter going whereve=
r
> >>> there's enough space for a Linux image.
> >>>
> >>>>> +
> >>>>> +             fit {
> >>>>> +                     insert-template =3D <&fit_falcon_template>;
> >>>>> +             };
> >>>>> +     };
> >>>>> +#endif
> >>>>>  #endif /* HAS_FIT */
> >>>>>
> >>>>>       simple-bin {
> >>>>> @@ -260,6 +350,25 @@
> >>>>>               };
> >>>>>               };
> >>>>>       };
> >>>>> +
> >>>>> +#ifdef CONFIG_SPL_OS_BOOT
> >>>>> +     simple-bin-usb472-falcon {
> >>>>
> >>>> Do we really need this? As you notice the BootROM loader is not real=
ly
> >>>> optimized for large payloads, I thought using a 1-2 MiB payload with
> >>>> TF-A + U-Boot proper was stretching it, sending a full Linux kernel =
seem
> >>>> like a big stretch, as evidenced by the 6 minute load time?
> >>>
> >>> It's neat for CI workloads and quick testing to jump straight to Linu=
x
> >>> without persistent storage or TFTP servers. I'm hoping to resolve the
> >>> slow boot ROM execution one way or another, maybe by poking some CRU
> >>> registers from boost.bin.
> >>
> >> On RK3576 the extra long load time could likely be improved by adjusti=
ng
> >> core clocks before/after DRAM init runs. I have not tried to figure ou=
t
> >> what boost.bin v1.03 does to improve UFS boot speeds but likely some
> >> clock tuning is going on.
> >>
> >>>
> >>> There have also been attempts at enabling opensource TPL on RK3576 an=
d
> >>> RK356x, so if/when they land we would be free to adjust clocks much
> >>> earlier, hopefully making the boot faster. After all, it works
> >>> brilliantly when booting from fixed storage, so there isn't much
> >>> reason for it not to work from Maskrom, apart from the particular boo=
t
> >>> ROM on RK3576 being capricious (not sure if it applies to other RK
> >>> SoCs).
> >>
> >> Based on testing on quite a few RK SoCs there seem to be a mix of fast
> >> and slow crc16 implementations, possible some can be due to slow clock
> >> speed, but I also fear a few are using a very basic implementation tha=
t
> >> starves even cores running at full rates.
> >>
> >> E.g. on my decent x86 labgrid exporter using similar basic crc16
> >> implementation loading 472 image of about 2-3 MiB could take 30-60
> >> seconds, and using table lookup, it went down to a few seconds.
> >> I can only imagine load times on some of the weaker SoCs :-)
> >>
> >> This is the main reason behind commit 9d3d4d619252 ("rockchip: Reduce
> >> size of ramboot usb472 payload"), removing 1-2 MiB zero-padding could
> >> help load time by several seconds, even on faster SoCs that normally
> >> does not have core clocks adjusted in SPL/proper.
> >
> > Hi Jonas,
> >
> > I've done some further investigation into why usb472 takes so long
> > (with my trusty SWD probe). Turns out the boot ROM runs a bit-by-bit
> > CRC calculation on the usb472 payload, which is not done for any other
> > boot mode. Since the sole core runs with the MMU and caches off, it
> > effectively hits full DRAM latency on every byte, and then it spends
> > dozens of instructions on every byte performing unoptimized bit-by-bit
> > arithmetic for the checksum.
> >
> > The throughput I measured for this calculation is around 124 kB/s on
> > my RK3576 based Flipper One dev prototype. That's 5.47 min for my 39
> > MB Falcon Linux + initrd payload.
> >
> > On a bright side: if the checksum (last two bytes) in the uploaded
> > image is set to zero, it skips the whole CRC routine and jumps right
> > into the uploaded image with no delay.
> >
> > Thought this is worth sharing in case more people want to take the shor=
tcut.
>
> Nice find!
>
> I did some quick remote tests with setting crc=3D0 and can confirm this
> works on rk3506, rk3528, rk3576 and rv1106, so likely also on following
> RK SoCs:
>
>   ("2207", "110c"),  # RV1106
>   ("2207", "110e"),  # RV1103B
>   ("2207", "110f"),  # RV1126B
>
>   ("2207", "350c"),  # RK3528
>   ("2207", "350d"),  # RK3562
>   ("2207", "350e"),  # RK3576
>   ("2207", "350f"),  # RK3506
>   ("2207", "351a"),  # RK3572
>   ("2207", "351b"),  # RK3538
>
> Using crc=3D0 does not work on RK3568 or RK3588, will test more once I am
> closer to all my boards sometime next week :-)
>
> I tested using labgrid PR1721 and something like following diff:
>
> @@ -261,7 +262,12 @@ class RKUSBMaskrom:
>              data.append(0)
>
>          # append crc16 of data
> -        crc =3D crc16_ccitt_false(data)
> +        if self._dev.idProduct in (0x110c, 0x350c, 0x350e, 0x350f) and \
> +           len(data) > 0x40000:
> +            crc =3D 0
> +        else:
> +            crc =3D crc16_ccitt_false(data)
> +        print(f"Loading {code:x} image of size {len(data)} and crc {crc:=
04x}")
>          data.append(crc >> 8)
>          data.append(crc & 0xff)

Looks great, thanks for sharing!

In the meantime, I've also found another speedup. If I extend the
from-source boost.bin which we discussed in the separate thread to
also enable I-cache in EL3, and send it as usb471 before or after the
DDR init blob, then the CRC routine speeds up from 124 kB/s to 2 MB/s,
making it way more tolerable!

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
b/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
index abccf4cb1b9e..6f42109ec788 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
@@ -27,5 +27,25 @@ int _start(void)
         */
        *(sram) =3D 0x3ffff800;

+       /*
+        * Enable the EL3 instruction cache before returning to the BootROM=
.
+        *
+        * The ROM runs with MMU and caches off. After a Maskrom USB downlo=
ad
+        * to DRAM (command 0x472) it verifies the *entire* image with a
+        * bit-serial CRC-16 executed from slow, non-cacheable on-chip ROM.
+        * With the I-cache off, every byte costs ~101 uncached ROM instruc=
tion
+        * fetches, so image verification can take noticeable time (~124 KB=
/s).
+        * Turning on the EL3 I-cache lets the tiny CRC loop run from L1I,
+        * measured ~2 MB/s (~16x speedup). The bit persists into the ROM's
+        * 0x472/CRC path. Harmless for the SD/storage path (small 2nd stag=
e).
+        */
+       {
+               uint64_t sctlr;
+
+               asm volatile("mrs %0, sctlr_el3" : "=3Dr"(sctlr));
+               sctlr |=3D (1UL << 12);           /* SCTLR_EL3.I:
I-cache enable */
+               asm volatile("msr sctlr_el3, %0; isb" :: "r"(sctlr) : "memo=
ry");
+       }
+
        return 0;
 }

Best regards,
Alexey
