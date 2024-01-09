Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78380C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC9C878CD;
	Tue,  9 Jan 2024 13:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NlssD+KJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F05087864; Tue,  9 Jan 2024 11:37:34 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A158783F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 11:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1D05C100006;
 Tue,  9 Jan 2024 13:37:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1D05C100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704796646;
 bh=lulZG/49oMrMvr53kH7rNdacKnJY2ytDBJGjXv8nRp0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=NlssD+KJHL7MKC2y9xrb8q7atCziL4xSnSUwdDbsr1C6J1gTQ+JSNIQ7eSQqamSjG
 5kD9JudTlHFzfovfqa1Z1K6dlSteWgmHN4e4qsMsclgFpMniryHRqMsTXcnkSf/qLl
 9L6SnMFzbhHfxwuItEvG4TE0lADtwN3rqhPsGvcG1WpBvITNUWTcz98gNuMgdD+JVb
 zwWUbmQWaPzovUALl140sCyRX0N5nJlBztOMGSK/mfttz+4q9PO94sKRVVxPOmaFf2
 BGPiWs4KSsZBXDivC1Eydz+oJ8mNnhdOUgFU5Bz0KAUylryyHyu7hS7VXPUk/F6HGd
 kKJWQC/2bl/Ng==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  9 Jan 2024 13:37:25 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 13:37:25 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with
 mapi id 15.02.1118.040; Tue, 9 Jan 2024 13:37:25 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "jpewhacker@gmail.com" <jpewhacker@gmail.com>, "sjg@google.com"
 <sjg@google.com>, "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>,
 "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel
 <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] android_ab: don't ignore ab_control_store return code
Thread-Topic: [PATCH v2] android_ab: don't ignore ab_control_store return code
Thread-Index: AQHaNxxSYDLk1O2coEa/JDZpUGkMoLDRLyIA
Date: Tue, 9 Jan 2024 10:37:25 +0000
Message-ID: <20240109103720.j6vudgbx5fi74pq7@cab-wsm-0029881>
References: <20231225102247.76794-1-avromanov@salutedevices.com>
In-Reply-To: <20231225102247.76794-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B37B3FD195E8844A73713FBB030C4B8@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182496 [Jan 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/01/09 08:44:00 #23037611
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 09 Jan 2024 13:21:09 +0100
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

+ Tom Rini

Hello! Please, ping

On Mon, Dec 25, 2023 at 01:22:45PM +0300, Alexey Romanov wrote:
> ab_control_store() can return an error if writing to disk fails.
> In this case, we have to pass the error code to the caller.
>=20
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/android_ab.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 73b55c196c..af3c375e07 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -337,7 +337,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
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
> +			return ret;
> +		}
>  	}
> =20
>  #if ANDROID_AB_BACKUP_OFFSET
> @@ -346,8 +353,13 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
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
