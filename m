Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A1C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C2B80586;
	Wed, 22 Jan 2025 10:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j3/yFIfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A4180763; Wed, 22 Jan 2025 10:18:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A6680283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737537514; x=1738142314; i=xypron.glpk@gmx.de;
 bh=xKNjhr4FhLqR+qh2dGtEPN0BYWbfU2N/tc3EyR050wI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j3/yFIfA7Lw6XPLvO/Uh+CQ01oxOf3JhGV2tvXR5TcSC3lqdAd/VinyM7OCdssm9
 XH/LaXYf2d07OwQf3MvMPy/zBnj3yNexWhj07kdan5GzpOyQqSmM52Ye2rEeZ7xLz
 n2jI/ZGYThntx7aL/bZCC4OUJYetN3YaCiUASEkbjGq0/SqbT7hsyg3VJdpj9AcTH
 gk+m06xIOoK4R923ldUXuGdsg7KIp7JiBzHoGWyqYKqPUNT9UVWR+miPBSNDXCe+W
 p3nMHpCqN2UGB+mFx/ufJzeIqjGjE0GJk80MHjbyDhFjhsgXxdyGmDqZbMpJn7ae7
 TbZZ7UrBVJRY/5dsXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmUHp-1tAETD2ya9-00jGVs; Wed, 22
 Jan 2025 10:18:34 +0100
Message-ID: <648d934e-17fc-4f6d-9cb7-574e0144af8f@gmx.de>
Date: Wed, 22 Jan 2025 10:18:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] fs: add rename infrastructure
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-3-gabriel.dalimonte@gmail.com>
 <4a2a96b2-dc0e-4cd2-96c5-399d96f2b5fb@gmx.de>
Content-Language: en-US
In-Reply-To: <4a2a96b2-dc0e-4cd2-96c5-399d96f2b5fb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a6qXTdPUh/BiZuWP5VNEa/KFj2BMxU11O9s97l397CnT4uqoMls
 wWDj6jEwCN6txTM8x1taNjbzSziOGejO6ANyBFsDwQewkYM1Zonfwgc0vQR/gx3Krnqawba
 blfH1+XI8rwfLWGw+NRFm2a2JZCUIY6lZkI/SqpIrkQRbnWcP1QrylBXA3KvF9UzBOvyAjo
 rVaHzmht6p3UVEW641lZg==
UI-OutboundReport: notjunk:1;M01:P0:i5w2YPVpuRI=;+7QvPV+xjg+ThyWg7pOX2U5itS4
 w75fx0K8ASmifmjQ2GxM2xMoY209Qs1o4vqn4TgW5qBfUbclSu8WITcw+XCSblnX3X5KQbDug
 w+OyZMYFedB3lTp+eXQr/l/04bbIwxTZxPN6/OuJghWglJyEnLl2RzC7umlIp1iBCs0VbBmia
 MomijjPvaH+36NRLIPx+R/AzMcVggDYxr6onZD7OFmprLaNRDjz56kflb9osr+dhr4LVPmeCj
 9fzzKQHHDkJC/q6vF48kH/WqEIcn3I+CvHVq6F2EBGCy0UzKQQEybSbfYWU6XvpcfsmicWyXl
 pGZvHwb1GkSkDvoT5zo28g6TLi0bLNizs8xqxim9KRZ/lGuF8bzDeiOZVXzLDFKw8T2o6yaLn
 mcTPhlYkJI8Fur8GZJiVugzNjR+IUhk9DmdhUMQN0bY5RtMR4RFOHqzomoBS9Y9kEcw5Fs10w
 /84Hgw74xaYc6Sj86z0P3eH10tVmxUbck1E33Dj8KfGAIT/Uevuj2lmELbdho9paGT9WANhp4
 6+AZ6WCYaEYPqW7tSIebnBaofTzNZbKnHGauelNU+etStaIQOVa9umAPoK+6hzQKHvYFvZHAV
 4AZPHuG+Ii7hCzBh0MAMOY35fekl92WygVfmcjKLV8jQ/pXd0T6PJ2zc6IuZJT80FcAiq81di
 rpIwyLK2KJrNaxEKTuiZunX4wS5UD+rUjPVHDC8zzP+jE2+jcTL1LtBIR8ASrX0Pq/Q4yLsOJ
 aV95zEEtbudz1T2DbeGd+5+NdPr1F0BB7IAikWWQNIKIDS0W0aEiDL4DJu/QwAOOVTOmmAry8
 xntg1BoqAzyC8YuOszmVWpQMlzcJVl4QaxqOo3mxpz43Q2ImYj3J/o3d2IsNRWeieKuLoN0hO
 EOk9lPCYbHPFT3/HBx10yPE2KcJZxaFDrHzmE8hfQs8qg+K+gT3rn01lgTDdYyBjqqodnyg1e
 8gvi65jMFhjXp9cu0Fwwku5HVqL+ipOT2zw4Y0TDoVwe8uupL46IRMw/yX/Hm1zLtdYjahh/H
 iGOfRf5ThKU79EDbS5AAggdvMZKiFpSJO8HdgyBV8gcP5Nj/rpsljoxVzJQszEzFi6ZnlbJPE
 0MMtAgSocsuPjvx4ZjwMjoKi972IezgORmiflSUIaGWbse3XBWBFeaTlh0C8U9yYigIv1S70W
 +l1mBQB/7GiCbSe28knBCil/HBoAEqKv1IvjrvIxKFA==
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

On 22.01.25 09:10, Heinrich Schuchardt wrote:
> On 22.01.25 06:32, Gabriel Dalimonte wrote:
>> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
>> ---
>
> Please, add a commit message.
>
>>
>> =C2=A0 fs/fs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 47 +++++++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0 include/fs.h | 13 +++++++++++++
>> =C2=A0 2 files changed, 60 insertions(+)
>>
>> diff --git a/fs/fs.c b/fs/fs.c
>> index 99ddcc5e37..160a43c957 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char
>> *dirname)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0 }
>>
>> +static inline int fs_rename_unsupported(const char *old_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *new_path)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return -1;
>> +}
>> +
>> =C2=A0 struct fstype_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fstype;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *name;
>> @@ -183,6 +189,7 @@ struct fstype_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*unlink)(const char *filename);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*mkdir)(const char *dirname);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*ln)(const char *filename, const ch=
ar *target);
>> +=C2=A0=C2=A0=C2=A0 int (*rename)(const char *old_path, const char *new=
_path);
>> =C2=A0 };
>>
>> =C2=A0 static struct fstype_info fstypes[] =3D {
>> @@ -206,6 +213,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> =C2=A0 #endif
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .uuid =3D fat_uu=
id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .opendir =3D fat=
_opendir,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .readdir =3D fat=
_readdir,
>> @@ -238,6 +246,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .closedir =3D ex=
t4fs_closedir,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0 #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
>> @@ -257,6 +266,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0 #if CONFIG_IS_ENABLED(SEMIHOSTING)
>> @@ -276,6 +286,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0 #ifndef CONFIG_XPL_BUILD
>> @@ -296,6 +307,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0 #endif
>> @@ -317,6 +329,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0 #endif
>> @@ -339,6 +352,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0 #if IS_ENABLED(CONFIG_FS_EROFS)
>> @@ -360,6 +374,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> @@ -378,6 +393,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fs_mk=
dir_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ln =3D fs_ln_un=
supported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 };
>>
>> @@ -713,6 +729,22 @@ int fs_ln(const char *fname, const char *target)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>> +int fs_rename(const char *old_path, const char *new_path)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct fstype_info *info =3D fs_get_info(fs_type);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D info->rename(old_path, new_path);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("** Unable to renam=
e %s -> %s **\n", old_path,
>> new_path);
>
> We should not write messages by default. This will may lead to output
> layout in EFI applications looking wrong.
>
> log_debug() would be adequate.
>
> We don't need the "** " first characters.
>
> Otherwise the patch looks good to me.
>
> Best regards
>
> Heinrich
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 fs_close();
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 int do_size(struct cmd_tbl *cmdtp, int flag, int argc, char *con=
st
>> argv[],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fstype)
>> =C2=A0 {
>> @@ -975,6 +1007,21 @@ int do_ln(struct cmd_tbl *cmdtp, int flag, int
>> argc, char *const argv[],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>> +int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>> argv[],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fstype)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (argc !=3D 5)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return CMD_RET_USAGE;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fs_set_blk_dev(argv[1], argv[2], fstype))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fs_rename(argv[3], argv[4]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char =
*
>> const argv[])
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fstype_info *drv =3D fstypes;
>> diff --git a/include/fs.h b/include/fs.h
>> index 2474880385..24b121f55d 100644
>> --- a/include/fs.h
>> +++ b/include/fs.h
>> @@ -270,6 +270,17 @@ int fs_unlink(const char *filename);
>> =C2=A0=C2=A0 */
>> =C2=A0 int fs_mkdir(const char *filename);
>>
>> +/**
>> + * fs_rename - rename a file or directory

Shouldn't this function be called fs_move() and allow moving a file from
one directory to another?

>> + *
>> + * @old_path: existing path of the file/directory to rename
>> + * @new_path: new path of the file/directory. If this points to an
>> existing
>> + * file or empty directory, the existing file/directory will be
>> unlinked.

What happens if the directory is non-empty?

I would prefer a real move function that copies the old file to the
pre-existing target directory.

Best regards

Heinrich

>> + *
>> + * Return: 0 on success, -1 on error conditions
>> + */
>> +int fs_rename(const char *old_path, const char *new_path);
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Common implementation for various filesystem commands, o=
ptionally
>> limited
>> =C2=A0=C2=A0 * to a specific filesystem type via the fstype parameter.
>> @@ -290,6 +301,8 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int
>> argc, char *const argv[],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fstype=
);
>> =C2=A0 int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>> argv[],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fstype);
>> +int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>> argv[],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fstype);
>>
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Determine the UUID of the specified filesystem and print=
 it.
>> Optionally it is
>

