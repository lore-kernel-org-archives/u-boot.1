Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB19FEEF3E
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968C5840BE;
	Tue,  7 Apr 2026 15:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="KPfO+M4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34F784180; Tue,  7 Apr 2026 15:15:59 +0200 (CEST)
Received: from outbound-ip199b.ess.barracuda.com
 (outbound-ip199b.ess.barracuda.com [209.222.82.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AA183F98
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
 by mx-outbound23-36.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 07 Apr 2026 13:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duG1xnfBlUNWduvK9tjoCZSKnDTN1cqo3eZ7NsuYpABqo7Svcu4/42Y0P2dcsMgXBREVw31G5dmssTnwh81hxmkhNdBNERbJlL64ramj9/KdSTDa8TlTD5/CJp0nFc10bOLt8DPD9QuvflJgf7vpuMEK1nvr2yfJmDki4B2uSRQt/nryvsamwCsLoG7zT7E5Mp2mWL9kUE39HZayz/zAalE0BMEFGrBW4lG1vzoguRV6NNwBARO6XIQVQuDop6EDHDLyVVfABsgRQOYJdfRIiKFdHBEYSTsG/jiMZopAwiek2/2jHURByfwHm83AzSzxq48sUrYB16IYvzTrTv2s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFUwJ+xtFyW9BunwsIDejkSo2VMir1+BWoFKCsw6Jrw=;
 b=nCSFFbV2mmn2gaQkwTzjuz9i7/lvwDyqli6RdZMjsdQzIkWY/iMIHygPpX3P1ZmcFyGcEZB8JRw6LIsAre9muPPV95VzjGmPY9yxT0maZj5dDRIWsqgXL/gZ2m25r47bwRI3YvYRtQ2hmmQDT4RqbA96SlJOMmPuHZYfSSEADiVAz6YZt+aAUFKlbvqHxhh6GdBUa/nKbOSikN1tDcQUWCUJaDy4JSMfa4PwiIjPd7Yuw6zc7GEEeaUDerKXmrt+f3cbbHf9wm+JINZny0WJcr5w/60qwoN0mR1nSmmab+bpMuWguW8P6aDdEFekpaeEdS2koKJigzUT8nyL0Nfecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFUwJ+xtFyW9BunwsIDejkSo2VMir1+BWoFKCsw6Jrw=;
 b=KPfO+M4sN8i+QiVDNvmeFknsCC3qec4geT3Yt7YWYPA+RiO0x+dM7F7Rk0V/IGfHA4xjTKN4WDScReojWCRXQbZxD6eIN2CrNOwPUjjbnVh4E+Rnss1THBzS6lQ3t3EdPFpQMfaPsfB09dyFnL9JcoTxNX/YiLPfga30nyt5SZOcAtUyF6eFFW7RQJor0wNSd9gwY3rkfP6oSdtEIoSQo5viA2UG8OPtsmsx2USlGLKj29Bsxy/mr3Y3OwYYdeFBifmSxrLOJspdVILrApooDLeqmPDRMiKaespCre5aIKOizc8aIT3g0rKrxvfbJr0/X37eaZsvA5rUc4jF/OchPw==
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 13:15:49 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d%6]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 13:15:49 +0000
From: "Viguera, Javier" <Javier.Viguera@digi.com>
To: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] rtc: rv3028: fix PORF flag not being cleared
Thread-Topic: [PATCH] rtc: rv3028: fix PORF flag not being cleared
Thread-Index: AQHcsIhPDhMY9CpwBk2I4ZKcP0YrBbXTvtLc
Date: Tue, 7 Apr 2026 13:15:49 +0000
Message-ID: <BLAPR10MB5156AD27BEA53C46BB17EE08E05AA@BLAPR10MB5156.namprd10.prod.outlook.com>
References: <20260310122033.2037427-1-javier.viguera@digi.com>
In-Reply-To: <20260310122033.2037427-1-javier.viguera@digi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6422b22e-4331-4b6a-b9e6-d9947ce1a902_Enabled=True;
 MSIP_Label_6422b22e-4331-4b6a-b9e6-d9947ce1a902_SiteId=abb4cdb7-1b7e-483e-a143-7ebfd1184b9e;
 MSIP_Label_6422b22e-4331-4b6a-b9e6-d9947ce1a902_SetDate=2026-04-07T13:15:47.967Z;
 MSIP_Label_6422b22e-4331-4b6a-b9e6-d9947ce1a902_Name=All Employees
 (unrestricted); MSIP_Label_6422b22e-4331-4b6a-b9e6-d9947ce1a902_ContentBits=1;
 MSIP_Label_6422b22e-4331-4b6a-b9e6-d9947ce1a902_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5156:EE_|SJ0PR10MB5694:EE_
x-ms-office365-filtering-correlation-id: 1bd111b6-45a5-47fb-8647-08de94a7c958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700021|13003099007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: J/LHzxjRJm+Rd/Oo5EnPEhhl/W+X5sehlSr03ZHLlckKy9eCANa6GulxwPXgineZF1W2BdFyZG68vXkEWztxngsBqnXT4wnt/yBDYPdVRVxcj1v+AtfSKeoP4qbPApJZ1xkirstP3kX7VlClBffT5pOM1cus3Jy/GK9KVskQJFDCtwFx32xe4F0uAbDn7vPdIWqY2jruwjtfXxp5Lw8aoyG8HE47RWFLrkemFr3apfFLACFRb4YYpA+x7QmBh9b1J5WdrJaZ8f+LNdYxUefciKivvjLr0CRZGrOR9IbWmrpwClYIoX58NmGhGpnqxMAsVQLLWVn3jhnMYTSMlL5Hu/anz/cX7X79R3qOj3e4P+Cbscd7CZkX7dq9xOxkQiqXvHITyTZyzK2i3KM/hJenQPCGqpUcScIN30DRl0LHcd7T3N0V6yBjcpbfIJC+x7URZgM7wBw8G4yUVajlZFgT0iGmDxqAX6Cv7KRGwz9gbohxLgv35jEaJoUVR7dhetc08EfxfsQ2eEoEPmEzepRD2VGEp+qn9W/JdOdN6uRopJFDAbKCeW247juurmtxhluissrqhggRL2CDk5GT1Kpay7K/Qk8esnu9A7uHBVS28NynTqVbNGGI9/lovTTGisEnJcqESJphkQ8B7uDux2V9J1HaJvEb+3R+b5tQOg+qodKjOrQQIVCPKFheEhYw7Gl5188dKptaPmp3nD+AVo6vtj7xoB9/0s0Ort24Q/+6I134KWLkJSk/8hiWnksXfrIV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700021)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GiwTfY4jyZ1lZcXRWa9+57pgURNsKUPwkrkL7/5UaE3OkR04VDVOgOT8frSj?=
 =?us-ascii?Q?IE7CcJJ3ElXD8QrWPvQS0f7MA23AUqtUZZGQTZ8qMRV1lT7U13mp3UXH8YnV?=
 =?us-ascii?Q?TQsAkUIKr7OQdP2YJ2t/GS/DvB5ANURDNoknbKKVuwtM1/L7St/IllWxWu2g?=
 =?us-ascii?Q?22kkNvftyqS1hvRerWWmUaLRhkTgLLMvARuj/SPQ5WAJHKrkNUoCAGLQhuMg?=
 =?us-ascii?Q?66+u1D8StkofEYWsq0VMBjOjmRh0YSrHFKKI5Vf5T8HziujALC24+29gKMPq?=
 =?us-ascii?Q?/UfLn8KxIWWQcNiooiVrcD4bvoWK86xj7BEA4qaex5vcnOOaQAhUYx1Je98l?=
 =?us-ascii?Q?kvX0e/EniipDwaPT3Z0Q+WyL1/GPvnowjcBaIIBrFGFu2+7P1Wqt0lbp5rpd?=
 =?us-ascii?Q?30LI6+1FBONod00ze7edDDHlCqsYkPQMANEaG9Hbq0wQ9BvFw/SZoBsxhPOD?=
 =?us-ascii?Q?aCOKPAakW33MM38SfNLqsDfY9e7HvLk5L8GSUha2AdxHGzTk+IqcdwLMHYfG?=
 =?us-ascii?Q?SvJn4nryWtzDiZYEoQ02xObi5e7Jt1kCJNawVLI5a/3THiTL5p2e1iOdflWR?=
 =?us-ascii?Q?JN2ueoFr/1WMretHq8TjY+4naK397C2Bfl7PZbAff6aTS6KAPX7N4e/VCs7D?=
 =?us-ascii?Q?NYaKmcjL6yxV7AZ2F3XlHHKMZ0aBJKcHdTPuHj4S/QCBDq9jsAsiBGX/JrPy?=
 =?us-ascii?Q?Xj48PZD4FK64BSAV2WvqmbJ1MqfsMPH+szA6kbPciq0jGMBHTrUaecnR+P9I?=
 =?us-ascii?Q?CUJ+KXb30DYfW29JbBmVKvEUvCc0GxBwZVK+al4lLg1ltiWlvH3loJNBlPfh?=
 =?us-ascii?Q?hsy3yb0GX21CraV95ew6/D2TYH4kgwBcsvED5ilhYeZ/s4Edl4kyTexquLt1?=
 =?us-ascii?Q?ftovo4SAjGQ9tYxw8t/2gtA8ovdCXI5jxOu/ScnXrV21QFW8USb8hNEW91aA?=
 =?us-ascii?Q?I2SJ3ik3+wDXrlOqCvaM6wBv5Se4nYlpq0e1gpDKFjAK86JcQgnCtHbLQ90P?=
 =?us-ascii?Q?925Q4RiphNoTzC0/yz7qXWlAYr/Brt+akYFn1qlSJTlzCQzHl874YpcqOWhS?=
 =?us-ascii?Q?XsDbGyw6QSuBchaPdi8IP83wnxxiLmHTmD2HQlBkCtBW1FjIIO6dsuiXyTOV?=
 =?us-ascii?Q?c8PblOFAEaThZV8TKEe9UUyhpSdpRDZSrO0zCBJgavWcVP0tmdw8Yo92Yeqm?=
 =?us-ascii?Q?oSxLS8jieciBWeVXWAqv6DSH2+f/HtqKsJ4ICReQSCZ29fiC4EcwW8sLI4xf?=
 =?us-ascii?Q?g9iq14bSdK692YXKQNg0EoAi8seWOppRi69lJutwZD4qCwQ/BhVqLTGaG77+?=
 =?us-ascii?Q?CIosr46KcI2gk/7WBlefR+VUWU/sUKlZyJh3H/6nZC2IL+VyNMdUjfj7JOas?=
 =?us-ascii?Q?Faqotjma9D1nEGksQ1yRE/Q4xsgm0x2UO37PMVwGSSEqgo4n/cDsQfqHHcQT?=
 =?us-ascii?Q?FssNmsjR4SfxvLWcxpWeFE1W50NMGoY/ymNHWr+rNG/aLyFGeUWW/t2qeF7O?=
 =?us-ascii?Q?y0bu/KXwc1dkCCYUCX4Wk4JvZQgyH4SZEmM3QFp70SsW11VCrsFduGDEouhB?=
 =?us-ascii?Q?G8NMe/Hq9vOom9zooxOzMyPI+uCc+4iDNKB/UXMTNrc3iAHbpdhLtdCNCQF6?=
 =?us-ascii?Q?6sjg0+WT/DkFJuUabEOt7QgKDZhQakdy1jtJOdSKM5zIrhbnP2essv/daTx2?=
 =?us-ascii?Q?xgVpj5ISQAaxp4oekMIKVx5p9Pw8YFn4jk8SPHYAFA5sk5rc?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pgVsMZpynbs/e0j0M7G8nBcHB6FnWQkrJg6L6S2qVd34g7qnSpv3LTBoPrinhLokVs9/nqeSzo2iiixfHhuDissJrvhfEHYvqGDNGPlyBeHxgWSqzh2YtZ9+94YvHlDC4GBvbGDnVLOPXvICosFWV9ejhgWYnBfgIDcBFMAB6Lf//SUAXbqNJE46jVoplgPU6HfzslP9LbYQRZvLIHwgFxy4OYKkNXQGxq/WaVC2ZisbkMXcZA+zdD0ygkXAo2tu/kXGkEBdi2+4HOynOR3MNoOEwatgwJieZvHIsZDSkSY4mC2MYElRtgKQbeNALGqEb34uDS3yUvsPTnXD7q6mwg==
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd111b6-45a5-47fb-8647-08de94a7c958
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:15:49.0741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gv/EtTEEubXI2jqRv+iveHLtC7W4x8ggIfEatPcuYSMQoyViNhhRIcsQLtwWFC1ICX+16C/tTqVq6/Oj1Vi4UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694
X-BESS-ID: 1775567753-105924-7700-8136-1
X-BESS-VER: 2019.1_20260402.1619
X-BESS-Apparent-Source-IP: 52.101.62.74
X-BESS-Parts: H4sIAAAAAAACAzXLsQrDMAyE4XfRnCGKlZOcVykd7FgiS+lQD4WSd6+HZDl+Dr
 7Hj/zbaaM+dqL3hzbW2UYd45RYDS1ncFsKDKpmS3CT5LvwznROtz/66/IiSS9fS00Fsy
 OQOAJ1HdBKVW8cnkHn8w/c+x5WgQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.272374 [from 
 cloudscan21-208.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Content-Type: text/plain; charset="us-ascii"
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

Hi Tom,

Any comment for this patch?

--
Regards,
Javier Viguera
________________________________
From: Viguera, Javier
Sent: Tuesday, March 10, 2026 13:20
To: trini@konsulko.com <trini@konsulko.com>; u-boot@lists.denx.de <u-boot@l=
ists.denx.de>
Subject: [PATCH] rtc: rv3028: fix PORF flag not being cleared

The current code sets RV3028_STATUS_PORF instead of clearing it, so the
flag remains asserted. Use dm_i2c_reg_clrset() to clear the bit.

Signed-off-by: Javier Viguera <javier.viguera@digi.com>
---
 drivers/rtc/rv3028.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Based on Linux driver:
https://elixir.bootlin.com/linux/v6.19.6/source/drivers/rtc/rtc-rv3028.c#L3=
38

diff --git a/drivers/rtc/rv3028.c b/drivers/rtc/rv3028.c
index b14d2a246ffc..4e05ef8de2a2 100644
--- a/drivers/rtc/rv3028.c
+++ b/drivers/rtc/rv3028.c
@@ -130,7 +130,6 @@ static int rv3028_rtc_get(struct udevice *dev, struct r=
tc_time *tm)
 static int rv3028_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 {
         u8 regs[RTC_RV3028_LEN];
-       u8 status;
         int ret;

         debug("%s: %4d-%02d-%02d (wday=3D%d( %2d:%02d:%02d\n",
@@ -157,13 +156,7 @@ static int rv3028_rtc_set(struct udevice *dev, const s=
truct rtc_time *tm)
                 return ret;
         }

-       ret =3D dm_i2c_read(dev, RV3028_STATUS, &status, 1);
-       if (ret < 0) {
-               printf("%s: error reading RTC status: %x\n", __func__, ret)=
;
-               return -EIO;
-       }
-       status |=3D RV3028_STATUS_PORF;
-       return dm_i2c_write(dev, RV3028_STATUS, &status, 1);
+       return dm_i2c_reg_clrset(dev, RV3028_STATUS, RV3028_STATUS_PORF, 0)=
;
 }

 static int rv3028_rtc_reset(struct udevice *dev)
