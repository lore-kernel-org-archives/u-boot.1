Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961D1E81A25
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 14:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE4B80FA1;
	Mon, 16 Feb 2026 15:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ZTza1/K3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F81383AB7; Mon, 16 Feb 2026 11:31:07 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB548063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ShakirovShM@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpVenhGPYfLtEK8UaCTyGdOGmEL1ADtLj1GTrPDWa4RUGIJBV1L2407/XbI/X8e8DKFRhLiqg/5eY8CUFYyOTItrYXe37z4ZDWUsONlqnMoOv7Nk7pZZdMJueSF3uOJiJk8SeuwGo2UA/5nI2mln1+QgCPCKx+qdzLeN9JcPFvzYbySdoiYlO3uzTZc2XhYRSWjFMURRgaE2vHD2nSxIcUbOyFI8TNNlLw/eplLTTH9PKX8YhMh/vGRiv+GHg6WrYPzQnCxXq4iB+KKfS7FhRkW1swIVYh0Mn3STwJEfIpG8u3dLWvjAtVLTTwpaeL6cX5YYPcIG6gNdNN8nWkvfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFtZKbtC7oAsYCzOzEb/vqS6zZrOO5rUs2B+Ge0DL6s=;
 b=fpzyP/Md+VvjZuTVwpBCKLk1LEOVF6y1KA7w1eURaj9NTHYxI3ELZPaDcp2wMiZIGKKpDIOf3+LzBhL3O0+B9FSDCmX23zBLovkYgMyalGNCKjznmUSRQsLagetkAnuRCJ4cPJR+S+WDQJZU4xrQXTY0ptJpokI2cfsweP1IzPBdmGsS7GF90LtYouTrzT5hE6RtRTRi8TUbuXyK4jYqDOjH10+HPWML5Rg68M9Vb06I7jQRcT/56n9AmFDUf6/IAP/rslx4k00UK9NJYD8cgiosNj6b3Zu18+LlJDP4+U2pdQhm2JS7tF5FTrCrPRKx8y6V4JHR/SIxA+Sx7mvopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFtZKbtC7oAsYCzOzEb/vqS6zZrOO5rUs2B+Ge0DL6s=;
 b=ZTza1/K30wXa+WSWIEZ76LCdmtEf+aIgMqvah8j0un+SXne4U49j/+5X2IXgFpJTMcj5q0R+68AhJ40GJTT7NZbprIKt5yGbejekoj3TbOj+VGrx1hdW0cZkiWOd/e88ke4VQJHkletGW8Scc+KrT5qcFnmqe2iRmkQfggCvYv6jXPbtQkPVI/KHl8T+zDr8on6FOoxPbNWFXfJAxOXrJnu5z8HdOqaDEasfSNZHa6W/L85aOi5v3YZFzpKadNPFRaaaJPWuuKRqljv/BasT2Od2mOtg5mEO42/f8/MpA5HIpXoBcffedFuhvFoxbATXc8aggDk+J7rqyAha60a6Lw==
Received: from DB8P192MB0712.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:16b::14)
 by DU2PPF20D5E32E3.EURP192.PROD.OUTLOOK.COM (2603:10a6:18:3::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 16 Feb
 2026 10:31:03 +0000
Received: from DB8P192MB0712.EURP192.PROD.OUTLOOK.COM
 ([fe80::46:a7e7:3d41:bce4]) by DB8P192MB0712.EURP192.PROD.OUTLOOK.COM
 ([fe80::46:a7e7:3d41:bce4%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 10:31:02 +0000
From: Shakhrukh Shakirov <ShakirovShM@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: U-Boot
Thread-Topic: U-Boot
Thread-Index: AQHcny7W8jPV+iZUyEOlZvgu/PNiFw==
Date: Mon, 16 Feb 2026 10:31:02 +0000
Message-ID: <DB8P192MB0712F704088804328C117F95AA6CA@DB8P192MB0712.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P192MB0712:EE_|DU2PPF20D5E32E3:EE_
x-ms-office365-filtering-correlation-id: 04082972-4fc7-4790-ed8d-08de6d467bd7
x-ms-exchange-slblob-mailprops: ZotS1sRCahfgo6EQrepbirRbzeqay4MUIDVV+laX6eqU1TD0LJWttq9nZv0yXUPmbRspdA1Vm7TcCp0BOliL/qWf9QVpGNlDzYOMidbIK3bKIuAlHlqRozPd4tuJaOZVKA53Te81xiebKPy8gdpBnGHyBOgy6vqMuc9RN/r1mWXs6YWZEHA7mCNRYl6CBSVCFRaDDNLayVEx/5ZgynOysER5YUeWJgc4zS1u1Eor7jEGzSja0/vdu3ZjaOKCvntRlIWmfauhiYpUTqGeU4lDZ4kpjy2Nr2sI36LIdhsv5+ANqXm9dLKKq0l02RgQGt6DGAbeKnc1fpvcYdIaxSp+7Q+WukUJx1pDrfLWAUv0Ur8PoELZbUSUWl34f1z/yYPaZol6yRI8R2G64ZYRdFLKVJcT4XIhC15YqnAHuSwyClnkfGb+n3sPwv4sZhyQk0Dj4YbM9wJVBdAA70jHwV2MtEyK16kBB4eZXHfqWXIhbtc3gVL8zIfDthCcRpR5AFy+wQvf0+yJE4EcUAY+4Oe1k8T2TyvMyZkc1aRWu4+UzNe2o5KAhV7fmCvcyw0VyQPCXR1S2B8TxYBc1YwZW5qwL+Un90F9UBvGmjNA2CdMvu5cgcu67oB/j4UmwK/HmicBWR2JFNRRWKQVCLo7J9RCsah1BjQzqM0O
x-microsoft-antispam: BCL:0;
 ARA:14566002|39105399006|461199028|31061999003|20031999003|55001999003|15030799006|19110799012|15080799012|8060799015|8062599012|40105399003|3412199025|440099028|102099032|30101999003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+t7vMNC9+kDEQ9gdqc8YV3jzrSVsGybhVXQc+ZuN1t6z8XBBgoK9/IRK+9?=
 =?iso-8859-1?Q?N41AcBqPwS+qPz3/nW4iSsB+QN+OUCKvtrECutZemGaTeKg23/UOBhMl4L?=
 =?iso-8859-1?Q?QpSfVFt+lM81kn38//yTDtkVf20GodaNN4ZHYLYn25A1PBxCwPVY+0o3mw?=
 =?iso-8859-1?Q?n3uK6zP4m8ARgdeTMTyNMBlzEpqrHM4TZ5BOckXQV7wbtp8hAfi+NlNTsg?=
 =?iso-8859-1?Q?ts4n0UHk5XDAWJzsxR8oQIBnfDAnomscmjcrJ5NEzPJRFWROIbBNHwMDoB?=
 =?iso-8859-1?Q?yZ060RnBJAW6DPxVO2giVfASn6rf411a3gmVJ+shw05gA91COQXNvrApYn?=
 =?iso-8859-1?Q?Uwg7Xge+j99YOImpe/RM746GufNZ/QlPrp7CsBT9A0wUZ4xhi/1ZduGFOt?=
 =?iso-8859-1?Q?io2Gmr6G5Nq66q1fh0wTBheyium50w0tSYa8MTHsMjVfGOGOCyApfPvUiF?=
 =?iso-8859-1?Q?3wyFMAOiRL/koVHq92lq3wBnxszvisSnwMzBTawN43zhRpttE9pPPHDx+C?=
 =?iso-8859-1?Q?P0RtpLnv7TMJA02NH7AbPXWG7n6fdhgqOt3TF2qqLbqz2zCPX4oS/DIi9+?=
 =?iso-8859-1?Q?NyLXZL5RBCL1Ik7JashASleRd8j7xNY/4d3AZHuzdkFWcy0uyd2vEweqlH?=
 =?iso-8859-1?Q?amvRsOHOGj7MCHd8nHvdiADGXZeVYZQ9Z6CYj90RBZzXyRmfgrxFhaKkq5?=
 =?iso-8859-1?Q?ojFQDII89XyhKozRJlBv4NdCebIjJZqIINRpIJKj9kMuNhBtficGe7o64/?=
 =?iso-8859-1?Q?K+0Ywo36Dy9UN22JBmda6XMn+e58p+CYfFHJWGi7YBetAQwyps9383KcFk?=
 =?iso-8859-1?Q?5YYGfDtZU0To5UwXyTDf8u22eEEZy114Kl6A8/lBMact4P6M5l1hKzPM5l?=
 =?iso-8859-1?Q?ahK0P1bidtqwKdBVGGkKoDuxTxf6cnr8PwJA1KIFbdUIisTN9vfa7OoV7s?=
 =?iso-8859-1?Q?rRIwoR7ufJzk+4+gPK50cMStO33aN5g5Mz8gZdrS9T5lOZLRd7e7zdW+4V?=
 =?iso-8859-1?Q?NpmD6F/03gWE6AtaoESlXC10kvC9UBN2DMYs9lOD9a41H3lUxiwT9RIL+I?=
 =?iso-8859-1?Q?d/pqyRRvaFGIsYjhcxlYNPiZFjFa11xSQaa8IhWWLKIm6/iBhuSTRjGSEP?=
 =?iso-8859-1?Q?K3E3FyWGuIT8eT2dPHZGzmT8KcmZyHHKlOOHXbbswlPMJLe0rcMn8GtBza?=
 =?iso-8859-1?Q?tfJHrebB5XtFD6J/yuNCLjxxwPvdZZuwncebNNdknWMBUuoUtJjKaNf8ax?=
 =?iso-8859-1?Q?O5lL7OJWIhkChkdZAo9vP8SuFWTBtGM4x0WaY7pMEAz7eamrR2d62lJ929?=
 =?iso-8859-1?Q?Q4Q8MtpAU6GZhHQWHgQIGNJiYSMLocmzpt8Qt4QjfLnUJrA1VzFLEp9MYG?=
 =?iso-8859-1?Q?sxL21XiSZV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ivo3CmnLHRVy/lzJg3koKa24pJUTz7DVSulSM5kVCPB1PBpep7t7XN01mv?=
 =?iso-8859-1?Q?CWyLowVvfFmbbC9uO0pxYOsF1VcQp4O9fqxkujC2iBAzLF+cSfIB8A8BTh?=
 =?iso-8859-1?Q?Rko6IDHPS1YRylaBH4cUx/bWloN5Ci3bNzjxwXepwLdDj0G1BJ2kEROnpi?=
 =?iso-8859-1?Q?ttBLj/EMrZZ74Pg0JeWMdcmjcWY4OMLEbnbJLazzssY83et4S7+vQcFGad?=
 =?iso-8859-1?Q?gx1DaGSGM7LY/HnP3vIsQjuWIwToL4N3XJUaCV2hnuHe0li37R2xLWZLqx?=
 =?iso-8859-1?Q?Ildct8cVwLu1oYJM3rjbCX03eOruQFSINUax9g9kduAxDu9UunPfg6NKp2?=
 =?iso-8859-1?Q?wQREoNG6ADmmDYbbmOstck0ADZrGH5baLn5JMey571BAEnkGmVn7+piMoO?=
 =?iso-8859-1?Q?ygfpkGUitdsTmA8UhiiSiTzeJcNkMq2uwY3O4OFeBJ8oD4cROjK9h+SJxf?=
 =?iso-8859-1?Q?p6iKJXvNzq0w6Q7Oxteg8NkGNpoPj/9NXiU3KXRiLLZQAzIBkbYwxAxEkA?=
 =?iso-8859-1?Q?TPWsli+g3fdlvhNag+Z0YhvwkDSvy+eAZcPP4cEth2HkF0uNJDcFH/ArzZ?=
 =?iso-8859-1?Q?4AGrE2eO6D1yV+s2y/Bph8aaipaRK4gcIKUW0ExQagdm/0DxBtiJP1lBtM?=
 =?iso-8859-1?Q?6JvvSqqZ47Xs2/hESPiWdayO2WKhft6PGaEbh/jVbAlradXHtUBEnwOv2c?=
 =?iso-8859-1?Q?SfObUt2zml0oMtp9AuUGobYEM9GfAjVFNfiiOhIUqbZd05z6YyykM5Mwq9?=
 =?iso-8859-1?Q?C5r6c+OswKSF6BoJ7uIe8t+9fBddK2I++lWAaAgpSdTA38Z9rMFojUpCqw?=
 =?iso-8859-1?Q?e8v5HuqVzX5uhwU/rtsCjK6h0h0KqZ/saqFfppQpa4nG1tYg73jXC0mlwy?=
 =?iso-8859-1?Q?sPSeQF0hAL90I0e6IbISfeOck8kF3Y1c8r08rQMPMhsE7XfrUG0AWkov4k?=
 =?iso-8859-1?Q?q+x0ZEwZcgGc7znN57uV8vuO9JLHpB86x8ql8oeny2Mqoh4j6eluyQObQp?=
 =?iso-8859-1?Q?UEa5LKtNxNC8+InO4mgaG67jXGib1T6pePV63VZ04Md9W7ONCj+EgCSCQi?=
 =?iso-8859-1?Q?dmUMB+75TfbZ9Op3ExRjHabK87ZkqMPiwxMdDA4LeFQx4RhkeXRg+j7Ko4?=
 =?iso-8859-1?Q?fVdztObQCZ1Xkyx7C/EQ9eEL8uGsMb8zDBseHtEqbRtbfyscn2KiqdIUeH?=
 =?iso-8859-1?Q?YvQZnV2OQdesh+pZJlEMnVjmgLim2c4UpSO/a0AHK8LvMoHcSEJDSBkG/R?=
 =?iso-8859-1?Q?O7SrfaBeS+fdH18XWy26fAylflOTMEGPK9jfpTvFayPUPtXECHvqTR1TA0?=
 =?iso-8859-1?Q?mttOVdo1TPDCg9lCXJ3eyCR5H2/bul+oGVi73rS7xrYKTeIpoIqhahiSj1?=
 =?iso-8859-1?Q?8iQYaWoU69z0SY/ErKuhG18C6ueNQVgh6Iglf/s4pAiU3YHCzC+t7GrQ+I?=
 =?iso-8859-1?Q?3BD1YaRixb8RZVPS?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-ce714.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P192MB0712.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 04082972-4fc7-4790-ed8d-08de6d467bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 10:31:02.5568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPF20D5E32E3
X-Mailman-Approved-At: Mon, 16 Feb 2026 15:33:18 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi guys,

I need consultation regarding U-BOOT, how to realize following on Raspberry=
 pi 5:
We have 1 SD card which stores: U-BOOT, OS1, OS2, OS config
So UBOOT starts OS1 with OS config.
From OS1 I can upgrade OS2, and change boot orders (so it will run not OS1,=
 instead will run OS2 with OS config).
From OS2 I can update firmware of OS1.
In case of failure of OS1 or OS2, it will run other OS version.
With who can I consult and what would be the rate?

Thanks  in advance.

