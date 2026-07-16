Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D416C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D33E84CC7;
	Thu, 16 Jul 2026 11:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KiWCwPkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036ED84CCF; Thu, 16 Jul 2026 11:49:22 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67DE84AA8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 11:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr1ULZGtdbEo1DkqPNWttddQAVnnyyI/G7xUuLIIb+L1ZPOnkEKVogTh6xuQer5XwTbcnU8dqK/ENf2Q1vVo0yekKBmC53wh7aO0NlkclasLZimqI8gQZik1Sj+q7ec5elwQ9pukI+n0h7rlIwj/HU5K4f9zSx+AO7fEoafXRNhlRWi5j8uv0GzwzZANLP2JIHCoN/JfwOpwloNummSfohCdUYsE2Ob2tGf6ehp+2My4NjsCYHvTA5OksSRrIMwumxpp0NXtkGps44nw/GzJ+P1OJyGTpSSoDfHiYNflaqOjJfNDfINryUVTdQJgOve0I5/YHh1TpthTfpV3XgxWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jsRZ1KCrA7kzniSWRvN4t+IzdDBHMJiUm2xecBLD7U=;
 b=D2WCvkx/XM9RHTUlcbm4EV5XJiEx1OKEIFePG6cuh4xL56w99/f9mqoPTQuu88fgf+ANW4T+YVC8dRr486vNg2RhColdrUzRu1l2Yn1pFjyLzBtSMeMcNyYa8SeCduz5H8C4padPIz1KVIr9unIagSKgazKPvvBj3x4A3Ptp/eDtEsBk2VJ5MqUwpgZ+ckrKvgGb6kIKPqQQIRiZo51e03XhYvZ6licTB5AVcUkko9qWqNSibLwgJlesYfQ7kQ7FgQe3EMF+39/NPcjTu1lM9/U39b+/WQFzpd8MfavS0nVxTwotlkQFacQb1SzjV2IfdGUkDbCbG2HPPoEmL2JSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jsRZ1KCrA7kzniSWRvN4t+IzdDBHMJiUm2xecBLD7U=;
 b=KiWCwPkgR4icGgJAKsCXj1NR+xI88rqOZ1R0n1RAomHztxZkrRi6Zqp4c68SmaCALv2P/jWPiyYzANNko36kCSkgEwKdD06t2C/BAoM19kQVy928esgw8naLePLPDNJB+SP0IrQw5ZwHyyBS/akYaL/ra1A3bhBWPd/cZLIuXFjZFwvTUwalzDcFLLiQp6WaxZPLvFQyZontTWGZ0pN+DGdLrtIXyXX79PROp4573SQOxDZXMEhoXV/FUC8ITsMsqaMfLwD89TOLFxP9zYCTLjzjPc+2Tk44O1ILOJ6j7rx5OvtJ2xYvjA9Lgcs/5Vqfz7TGPIabHxukunwKdvfb3g==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PR3P195MB0618.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:30::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Thu, 16 Jul
 2026 09:49:15 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 09:49:15 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: INgo Rah <ingo.rah@linutronix.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Gregor
 Herburger <gregor.herburger@linutronix.de>, Benedikt Spranger
 <b.spranger@linutronix.de>
Subject: Re: [PATCH v2 2/2] board: phycore_imx8mm: add 1 and 4GB RAM timings
Thread-Topic: [PATCH v2 2/2] board: phycore_imx8mm: add 1 and 4GB RAM timings
Thread-Index: AQHdD7Ake1Bxb5YILEWwfXXqtsO3NLZv8VmA
Date: Thu, 16 Jul 2026 09:49:15 +0000
Message-ID: <d100d72ae11457f9105d7f42ad77aa3b291ae17e.camel@phytec.de>
References: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
 <20260709-ram_phygate-v2-2-36f8a2f44de2@linutronix.de>
In-Reply-To: <20260709-ram_phygate-v2-2-36f8a2f44de2@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PR3P195MB0618:EE_
x-ms-office365-filtering-correlation-id: 9da03108-f303-46e4-207d-08dee31f7f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|6133799003|56012099006|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info: iAqoNogjjke1j71Gn/R9NVQZgoBDw+ZyMAOrsk4znOitjU909jB2qGd6SOMmcQyYcepo79PfghkZXN5kIE8Y5xVtjJjYuYLSEpJuHohofnd4CDimfhvl3wOVy8JRTx4nAAKocsMde91N/TehlLws3UYcarIZ/mZosZR5rjvz1gPGBkYxao8TTSbD51UYdLakvicDk1UvIoZ3UCBp8zy8/6kCuAxRSoo73eNlnKrAo/VIQhrTVt9xzkVU+PyDCsvIUE8p1yvsnLQECM3KwvA3dAzLr/zmTE/SykOhyBZ3+McjXIWS7sijtnYnQ5GxUCADkiYk6/61ZgFNAnIt4upuhdWfqtDIGZVLOIl4OIWccEIsnJ9tipCih3/eHl5YvGZm0/+NqGT50ndjvdZ7Jdchb/jW+TTvxMJTna2615hhVLKt4GDy8Vp+63OEytj/dGfRGFgsCi9mg1YlT9E7o07vS1jryg0sxViVPgZCPxS816TRAzwdr2CoQU7wvAEHyo9RrOrXlweWj+PEV/QjJwRW0XDR2t4K0nvwU11CqFaifZVMK6WihS4nJ74T/ajxvoBHId97LcpQeMlf1uITXX9n8DCder1b0OKoEJfSW0T4621fsXqAyC5TRFtInHN/1xVA0y6BEeJiNQStrvCyW5xuNSjl0ftL9EktYG8aGkB0ICX0JIASQeTDVdAzWQOz4qrcaKR6zFLYZDjHxXdiRBdkbqNWSgbGU01yhk7/ryVC7eo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZvMDVRV3RZK2JTK1hUUWJ5UnltM0dweXJ0YTBoUU5ZbU9EMThnYWplYkdY?=
 =?utf-8?B?WEsyRnd6NmtqTFVhUjhaNWRFcFdIZXhhZDR4QXBBMU0wVHdjd1FIV1Q2akFQ?=
 =?utf-8?B?MDk1c2RPcGtDNmluRlN2NEhzbEVmdlIrMGpBT3Z2cGVhUjRRSW9uV2hldU1W?=
 =?utf-8?B?L00rMEE4ZzNOOU0xL2ZOVW1HcXEwa040TG90YzIvRzdFclovV1Y0NVVYWVZj?=
 =?utf-8?B?TTk2SUlKUDRUTmEwK01kd0ZPSnNvU1B0WVVGT2svNFV6U2RReDEvSXZkdlVK?=
 =?utf-8?B?a1N0WWd6cFBVTXcyemVGU3hkcEE1WEtiS0xkV1hpRlhwSXFOK3VjaVd0QnRG?=
 =?utf-8?B?Tm1xTSs1b3kyUnFkZHlzdG4vRUlRL3IxZVc5b2VXQWJEYjRSSGwzYlZnTUxE?=
 =?utf-8?B?OTVRODQ5dzlWTDVDN0c3Q3JGaGxpc2dDME05SU9PN1ZYVHYzREttTzRLaDgv?=
 =?utf-8?B?Ris2SHRuT2YvQzJtNmIrc2NQcmVRZFFxWjVjMjc0SU01QnZUWFk5dG5hcXcy?=
 =?utf-8?B?QzAveWh4SnZyWmVnZ1BPRW54TUhUd1RVVjNPRTM3WU5nVHVEcWRSWC9QMEdD?=
 =?utf-8?B?SDhiVEdib0tkWmpOdDFCQ05NUXl4RzFOTHBxdURpeWVNdHU2SFFEK0Z3Qk5l?=
 =?utf-8?B?WWtkYXFGS0VIVjdwMzJwZytwaFFhMitWem0yay91WUVUb3lKb25HazVCdUxk?=
 =?utf-8?B?b1ZrV2daTW9tMDNydEx2VEdzN1FZV3JuK3V2enVzbCtBREY0U1VjaW1RQ3A5?=
 =?utf-8?B?bEVON0QrMW1kNU1rMXloTFl3WjNRQW85WEtHL0U0SjZVejk4M3J3c25zblov?=
 =?utf-8?B?ckY2QTRZTG1kWTk5MTdDOC9pMUlqVnl5R05MQkc1aG9oalV4cnArUnloNFJv?=
 =?utf-8?B?U2tNbEJlTTVqVXlWVFNlZkVvcjlwS0VEOWRSanF0NU5idHFwZlQxeWdVcHZT?=
 =?utf-8?B?WlRFczhuenRHRDJGR1gwVklVRldDcW15RUQ5MWNMVWNrRUJYbUYzbWx1bThI?=
 =?utf-8?B?K3JxdTFEQmNMaVVGL1k1WDZ0NmlFdWhCbHA3azZNeTg0cEx0bVo5bkdnVlI4?=
 =?utf-8?B?OU5GdC9kUFR4TnRCUXc5cHFQTVExQndmZmJoQVdLNG8yenhkNDEySnE1Ujdu?=
 =?utf-8?B?RFVNVzNyU0VJMUQ5RFBqWms0c3VHQVc0K2hlYS85NEJlYUFFQmpoMGE5Uzhq?=
 =?utf-8?B?bVFwS2krdTlXYXBMK3RRSXlwa3VEdVRRaXAvaUJjb3Z6L2o5d3dsSjlHOFlR?=
 =?utf-8?B?OXNXUE94aExkT3ovNE5FSHN6UVhVajEyOGYyL2xZQXR2QTRQNlB0YmpBYitR?=
 =?utf-8?B?a010M0NQNGlBM1ZJaXlsSUhVYk9LdnNPOUcwZXlzZ2phdzFXWkkyRGtjbUIy?=
 =?utf-8?B?S041Q0lHU1RCV0czUGdBUnVaZ3ZOaE5Cb21MaXdPd3ZFbUVqaTllTVlyV3BD?=
 =?utf-8?B?TGlKYXI3OEtPY3BkK2lVV0Q2Mjl3TWEyUG9jeEJGWXFqRjlYdUdzMHdxTlVO?=
 =?utf-8?B?VXZadjlUVmJlaDVNTndmSnREYmdnU1U1d2RqSjMxcjB3bXNYQlBTVFdvU3Nz?=
 =?utf-8?B?Y05ja0xQeUxjclRXbitLU3FqTWNXZWF4My81OU8zcy9aVXJsZnVpakpLTXho?=
 =?utf-8?B?eGx6NnBTWUs3ZGNHeTIvWWF3YjlBSk1uRWRLZVFlNmswanh5WlVjalExL0c5?=
 =?utf-8?B?TzVqdTRqTXcrc3NuTkxBcG1Qc2lDNE9welJOZ2lrL3E0aTE1RGx4RnhsU1F2?=
 =?utf-8?B?bHBxTmZ5RXA3Zk13VDJnaThCUVZlS0lONzRoaXJaUFFkOFdNNU5oT0d2WXlV?=
 =?utf-8?B?SVFXbFJNSE1VOFh4SENSWVBBczVidlcveHdtOStxVE9UYnY1NDgzNXh5YXB0?=
 =?utf-8?B?RmlNcExUK2N6MEJSNWV0amRobjU1WTQvQ3dJM3cvWHBRVUF2Z0Zib3Q3b2Vy?=
 =?utf-8?B?My9qR3RDcjlhYnFkMUFnUm04TzBKaGt1enZUK2E4MEdLdk4xOEp3MzIybWIw?=
 =?utf-8?B?U01CZUYzTUZyZ2Fib083YnpPTlFsS3ZoeHNiUTRwL0UyTG5NL003SUdNZjRh?=
 =?utf-8?B?ckVCb2JJUy9pSlFzbEdZWE9pcjZYMDRnUWpGbGtyYzFNZUhMVlYvcUJ2Z0lh?=
 =?utf-8?B?eFVtd1JXWVVvcDJ2R1duZWxrcWljd1g0SmtOakdjZVJpdVV6Q0dqdE11MW5M?=
 =?utf-8?B?N1UwSDhCTE4yYlBQZ0ttdUpkeWxiQzJWdnJDdVNRWG9oWjdtWVVONlJ2UE5o?=
 =?utf-8?B?ck9PV3dtOVhCOWlFZ1FPM0ZUL2pxZzZma1FkaTdGQ1FkQkhzNGVGQk4reEJV?=
 =?utf-8?Q?zaPnHLG0EdnNKGAXno?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1970EBC9595146A2C40E8BB4027234@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da03108-f303-46e4-207d-08dee31f7f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:49:15.7206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISOUjNAmHN++ybk5F37ZTMU+mK9A7HdfJXoDl/lDyOypvec2zRzzWpNSKgDgtsHPxXw6r0+3FpP6XV6Vq4Ntow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0618
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDE2OjM0ICswMjAwLCBJTmdvIFJhaCB3cm90ZToKPiBUaGUg
UGh5dGVjIFRhdXJpIEwgaXMgc29sZCB3aXRoIG11bHRpcGxlIG1lbW9yeSBjb25maWd1cmF0aW9u
cyBiZXlvbmQgdGhlCj4gYmFzZSAyIEdCIHZhcmlhbnQuIFRvIHN1cHBvcnQgdGhlc2UgYWx0ZXJu
YXRpdmUgY2FwYWNpdGllcyBzZWFtbGVzc2x5LAo+IHJlYWQgdGhlIHBoeXNpY2FsIG1lbW9yeSBz
aXplIGRpcmVjdGx5IGZyb20gdGhlIEVFUFJPTSBvZiB0aGUgdW5kZXJseWluZwo+IHBoeUNPUkUg
bW9kdWxlIGFuZCBhcHBseSB0aGUgYXBwcm9wcmlhdGUgRERSIHRpbWluZyBwYXJhbWV0ZXJzIGF0
IHJ1bnRpbWUuCj4gCj4gQWx0ZXJuYXRpdmVseSwgYSBmaXhlZCBtZW1vcnkgY29uZmlndXJhdGlv
biBjYW4gc3RpbGwgYmUgZW5mb3JjZWQgdmlhIGEKPiBkZWRpY2F0ZWQgS2NvbmZpZyBvcHRpb24g
aWYgZHluYW1pYyBkZXRlY3Rpb24gaXMgbm90IGRlc2lyZWQuCj4gCj4gTm90ZSB0aGF0IHdoaWxl
IFUtQm9vdCBjb3JyZWN0bHkgZGlzY292ZXJzIHRoZSBmdWxsIHBoeXNpY2FsIG1lbW9yeSBiYW5r
LAo+IHRoZSBkZXZpY2UgdHJlZSBleGNsdWRlcyB0aGUgbWVtb3J5IGJleW9uZCAzIEdCwqAgKGJl
bG93IHRoZSA0IEdCIGJvdW5kYXJ5KS4KPiBUaGlzIGVuc3VyZXMgdGhhdCBVLUJvb3QgYWxsb2Nh
dGlvbnMgYW5kIGVhcmx5IEVGSSBzdGFnaW5nIGJ1ZmZlcnMgcmVtYWluCj4gc2FmZSBmcm9tIDMy
LWJpdCBpbnRlcmNvbm5lY3QgRE1BIGxpbWl0YXRpb25zIGluaGVyZW50IHRvIHNvbWUgaS5NWDhN
TQo+IElQIGJsb2Nrcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBJTmdvIFJhaCA8aW5nby5yYWhAbGlu
dXRyb25peC5kZT4KPiBSZXZpZXdlZC1ieTogR3JlZ29yIEhlcmJ1cmdlciA8Z3JlZ29yLmhlcmJ1
cmdlckBsaW51dHJvbml4LmRlPgo+IFJldmlld2VkLWJ5OiBCZW5lZGlrdCBTcHJhbmdlciA8Yi5z
cHJhbmdlckBsaW51dHJvbml4LmRlPgo+IC0tLQo+IMKgYXJjaC9hcm0vZHRzL2lteDhtbS1waHln
YXRlLXRhdXJpLWwtdS1ib290LmR0c2kgfCAyMyArKysrKysrKysKPiDCoGJvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDhtbS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNjUgKysrKysr
KysrKysrKysrKysrKysrKysrKwo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3BoeWNv
cmUtaW14OG1tLmPCoMKgwqAgfCAxOCArKysrKysrCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9p
bXg4bW0vc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNTYgKysrKysrKysrKysr
KysrKysrKystCj4gwqBjb25maWdzL2lteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29uZmlnwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKy0KPiDCoDYgZmlsZXMgY2hhbmdl
ZCwgMTY1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCgpbLi4uXQoKPiBkaWZmIC0t
Z2l0IGEvY29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZyBiL2NvbmZpZ3Mv
aW14OG1tLXBoeWdhdGUtdGF1cmktbF9kZWZjb25maWcKPiBpbmRleCA5ZGM3ZmUyMTgyMC4uM2Fl
OTJmZjA5ZjYgMTAwNjQ0Cj4gLS0tIGEvY29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2Rl
ZmNvbmZpZwo+ICsrKyBiL2NvbmZpZ3MvaW14OG1tLXBoeWdhdGUtdGF1cmktbF9kZWZjb25maWcK
PiBAQCAtNCw2ICs0LDcgQEAgQ09ORklHX1RFWFRfQkFTRT0weDQwMjAwMDAwCj4gwqBDT05GSUdf
U1lTX01BTExPQ19MRU49MHgyMDAwMDAwCj4gwqBDT05GSUdfU1BMX0dQSU89eQo+IMKgQ09ORklH
X1NQTF9MSUJDT01NT05fU1VQUE9SVD15Cj4gK0NPTkZJR19QSFlURUNfU09NX0RFVEVDVElPTj15
Cj4gwqBDT05GSUdfRU5WX1NJWkU9MHgxMDAwMAo+IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHgzQzAw
MDAKPiDCoENPTkZJR19ETV9HUElPPXkKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9jb25maWdzL3Bo
eWNvcmVfaW14OG1tLmggYi9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaAo+IGluZGV4
IDIwZTJhYjgzMmVlLi5kNDU3MWNjNmYzOSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3Mv
cGh5Y29yZV9pbXg4bW0uaAo+ICsrKyBiL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5o
Cj4gQEAgLTI4LDYgKzI4LDcgQEAKPiDCoCNkZWZpbmUgQ0ZHX1NZU19TRFJBTV9CQVNFCQkweDQw
MDAwMDAwCj4gwqAKPiDCoCNkZWZpbmUgUEhZU19TRFJBTQkJCTB4NDAwMDAwMDAKPiAtI2RlZmlu
ZSBQSFlTX1NEUkFNX1NJWkXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTWl8yRyAv
KiAyR0IgRERSICovCj4gLQo+ICsjZGVmaW5lIFBIWVNfU0RSQU1fU0laRcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIChTWl8yRyArIFNaXzFHKSAvKiAzR0IgKi8KPiArI2RlZmluZSBQ
SFlTX1NEUkFNXzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwMDAw
MDAwMAo+ICsjZGVmaW5lIFBIWVNfU0RSQU1fMl9TSVpFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFNaXzFHIC8qIDRHQiBERFIgKi8KCkkgdGhpbmsgdGhpcyBuZWVkcyBhIHNpbWlsYXIg
c29sdXRpb24gdG8KCmNvbW1pdCAzZDYzNGIwYjQ0NjAgKCJib2FyZDogZ2F0ZXdvcmtzOiB2ZW5p
Y2U6IHN3aXRjaCB0byAyLWJhbmsgZHJhbSBjb25maWciKQoKWWFubmljCgo+IMKgI2VuZGlmIC8q
IF9fUEhZQ09SRV9JTVg4TU1fSCAqLwo=
