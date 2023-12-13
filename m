Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3386FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 14:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980FD87509;
	Wed, 13 Dec 2023 15:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NOuFelvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7FF87103; Wed, 13 Dec 2023 10:56:49 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E70A865A8
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6D3D310004E;
 Wed, 13 Dec 2023 12:56:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D3D310004E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1702461406;
 bh=h4AMDxO55jdepvum4THrftRKw9rbSo7I8U6V63l4GTA=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=NOuFelvZMJXWm0oVCUlySoZNGoa0VXQr8jweYKYqb33ulGeB96hxdGrR/FhF1bQgr
 8FL9RX1dfwEH8AkkZMvw5iQwu6C8HN1qHeNISThtmAKNeUwMpwfNnA5PdBJMvvGWDc
 P2ffLAZzWvftw5OERmy6VLYQ01G1cLRTvvTHegCp7epyn3W5xl1JTM2pZH1JCAOlVQ
 Zh4QM29Nlpc4sjkRC3aBh02Kyvfnk2vJu//WTUexh+x9zGBU1fp+zEWVBQJLSXDQOo
 j0q1YtPUv+zAgg+MhZo5SXcOdSbOLmw0hbW7lXwmJsLbgy3iiSBqLQ+rORVQ+8TL6g
 6WP713x1kQS5Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 13 Dec 2023 12:56:46 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 12:56:46 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::3541:75cc:5c10:b970]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::3541:75cc:5c10:b970%7]) with
 mapi id 15.02.1118.040; Wed, 13 Dec 2023 12:56:46 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "jpewhacker@gmail.com" <jpewhacker@gmail.com>, "sjg@google.com"
 <sjg@google.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel
 <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] android_ab: don't ignore ab_control_store return code
Thread-Topic: [PATCH v1] android_ab: don't ignore ab_control_store return code
Thread-Index: AQHaIe3GyW7blpteqEO3PKdMB/8PkLCm3zGA
Date: Wed, 13 Dec 2023 09:56:45 +0000
Message-ID: <20231213095641.k7mtrquczkfcu6dm@cab-wsm-0029881>
References: <20231128112636.26655-1-avromanov@salutedevices.com>
In-Reply-To: <20231128112636.26655-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCAACDEA445B12499A4B5094DF2793C7@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182074 [Dec 13 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/13 06:29:00 #22674381
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 13 Dec 2023 15:29:33 +0100
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

Hello!

Really sorry for the noise, but please, take a look at my patch :)

On Tue, Nov 28, 2023 at 02:26:34PM +0300, Alexey Romanov wrote:
> ab_control_store() can return an error if writing to disk fails.
> In this case, we have to pass the error code to the caller.
>=20
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  boot/android_ab.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 73b55c196c..5a3152dd53 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -337,7 +337,15 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
 disk_partition *part_info,
> =20
>  	if (store_needed) {
>  		abc->crc32_le =3D ab_control_compute_crc(abc);
> -		ab_control_store(dev_desc, part_info, abc, 0);
> +		ret =3D ab_control_store(dev_desc, part_info, abc, 0);
> +		if (ret < 0) {
> +#if ANDROID_AB_BACKUP_OFFSET
> +			free(backup_abc);
> +#endif
> +			free(abc);
> +			log_err("ANDROID: failed to store boot control block: %d\n", ret);
> +			return ret;
> +		}
>  	}
> =20
>  #if ANDROID_AB_BACKUP_OFFSET
> @@ -346,8 +354,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
 disk_partition *part_info,
>  	 * to the backup offset
>  	 */
>  	if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> -		ab_control_store(dev_desc, part_info, abc,
> +		ret =3D ab_control_store(dev_desc, part_info, abc,
>  				 ANDROID_AB_BACKUP_OFFSET);
> +		if (ret < 0) {
> +			free(backup_abc);
> +			free(abc);
> +			log_err("ANDROID: failed to store boot control block: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  	free(backup_abc);
>  #endif
> --=20
> 2.39.2
>=20

--=20
Thank you,
Alexey=
