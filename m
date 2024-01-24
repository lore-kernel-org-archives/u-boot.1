Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ECAC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 17:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFCFC87763;
	Wed, 24 Jan 2024 18:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="p44t9Fkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443BF8778A; Wed, 24 Jan 2024 18:16:07 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80EBC87613
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 18:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1706116563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As5xQ35Pkmh0Y982zox/A2P43elvRKCSuaC1BEo0nUs=;
 b=p44t9Fkh3hWOLb8AnVS2pINFYncUbbpwT4h3YeJ4622xIONqNsq4t15iq6oZdtr70FSUT+
 fLP7TuyHuzenVUkiJOsH04jecIsdJ8OC3dkiMEq5zaVqWLKgnGa7yE6SXHFo1hHD3Gdy4t
 jJyirBJ61bYRIqRgAjT54kXOWWhm9JA=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-70-dMXp7IAlP5GWb3npxRrfxA-1; Wed, 24 Jan 2024 18:16:02 +0100
X-MC-Unique: dMXp7IAlP5GWb3npxRrfxA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR2P278MB1053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 24 Jan 2024 17:16:00 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae%6]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 17:16:00 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: REGRESSION: [PATCH 5/9] toradex: Use checkboard() instead of
 show_board_info()
Thread-Topic: REGRESSION: [PATCH 5/9] toradex: Use checkboard() instead of
 show_board_info()
Thread-Index: AQHaFd2HGTAr/HJ2/kCx1SfWDLvs2LDppoKA
Date: Wed, 24 Jan 2024 17:16:00 +0000
Message-ID: <e40ed93bd8f371ec56b8fc451dcb458f3ce6dcba.camel@toradex.com>
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-6-sjg@chromium.org>
In-Reply-To: <20231113030001.240020-6-sjg@chromium.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR2P278MB1053:EE_
x-ms-office365-filtering-correlation-id: 7dea637b-41c6-43d1-c7eb-08dc1d0022e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: mie5BBbCt+sVzfcbW2n8YTqp1+b3C1dsOACFCFfMtXmq438HlDAYrUuS3WBxweEp5SaxTuqXi55OvO/9rKoUqr9VaMbCLoNyxsUj2NMfgLiGcNmwO8xaOeYzbUC/YWnh5Ow+5ZcsvTK05rpPFzsaaPg2cKJFSfaXAhfFVQck6t1pnhsDD4w03MBBri1bq1KJO+24E8cEl6NzIYJ5RtOd4EXii5dVDuLbsbPNnalRE+0qkzXCsBbo1aZ80AdKhzJ2880ahoWJiFyvhxpdA5MgFLTyJuNRuhZnasBt+j0AAp94VIhov6JgORXUMe9fnmaoRKu7ct+CgCQQKvPlar2AC8QkrQzidtljAALrqfWQhlVZW/fieZuS00H+6prbwaJElzSrluc8R/Q89wWfQOJtYR1Uw/t6FS0vQjlF4bsXSbeBj7z5Go1L8wlzX2ySFyby7EJwexOMiJ9khja8PiLafncg/kZpxPOb1u1GZZEft1tidwXzBm/IfMNZ0FYTqnRKqZSHdDiCTou4sZUh0xWuWp+9emEaxhlA5jfpJD5V3MsDcQee13hqp3B4Hr4K3tsGKdY0WzbRT43HFBqP3jaSkKRZ/AwzS0JobYGCHWE3NaFzimeEZlMNVfrJu3vgVRmP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39850400004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(110136005)(38100700002)(44832011)(2906002)(5660300002)(122000001)(6486002)(478600001)(4001150100001)(6512007)(6506007)(36756003)(86362001)(71200400001)(8936002)(8676002)(66446008)(66556008)(66946007)(66476007)(64756008)(316002)(76116006)(38070700009)(2616005)(41300700001)(83380400001)(26005);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0o3TzlrOUxyd2lxazg3TFFTVGdHQWdzT3FXaDNWK1dTOVpOc05SbjJqVFJ0?=
 =?utf-8?B?Y0NWWTVDc0tOQXZ1ZmRFellZMDNFN1BHTnNhTTcweUtOaTBSNU9xVzd1T0xz?=
 =?utf-8?B?U0NydDVHUDdZQW1aL2FaMEMwVmZDNjJDSlJaVmtZalFQZGFDa0dESFc2SlhG?=
 =?utf-8?B?ekpLTTJKblM1Mi9iall3VzliMXRSZzhVN25ERld0cVdGWXU2TFJBR1BhT3lW?=
 =?utf-8?B?UGx1SlFDR0VZSzloTUlQejFLTlVDdlFUc01ZRU90dkRhSmIycDd4SENkTnNv?=
 =?utf-8?B?dGJTQS81dzFQd2tuZFEzbytqRjBDSTdxUDJFUjY0ZHlHYkpHSTBiZDhyNWE4?=
 =?utf-8?B?b0xVN3JPR2IrZWN0ZnpjaWh5VVBXTnAwZkQwa0trNVppOWxmUGxOWkRncXlR?=
 =?utf-8?B?OC9zeUJSVWdFYzcxOVBuclRNSHlVNk91RjhEYllEeFNiWnpadE9rbFZvMmxw?=
 =?utf-8?B?bXlSemlIdWFCSS9iUjFBSGNERjhyTXRZZ2RSYTU0MFIvT1V6bThWRTl6dmM1?=
 =?utf-8?B?U1ZoWnRlQ1Y1ajdiaGZiZkNuZVV2NnVOdldqUm1OM3Z3cUF1bzlGTjRSeXhU?=
 =?utf-8?B?UlJ1d0V6TDVKdnRsbU5rK3RveUhpaysxaldjWW9DWndSSWE3WldTdmlZdFk0?=
 =?utf-8?B?Y0E0cVhJV0ZneWMrUDRsaUhQeFgxNVVSc29oMEVHelFCbk5wSE9Sc0t0ODRr?=
 =?utf-8?B?YjJQZHZyU3RLSlV1R3VJK3M5UERkZ29Ia0Jrek9Gc2NZUzYwSWNFS1RGT0g0?=
 =?utf-8?B?MXB6OWlpcXlXVjl0d2hXdFNvT0RuTCtIbkNmN0JySkd5ZHpBRnZwYUZQZFpV?=
 =?utf-8?B?VXFCdTRoeTY2R3pxZG9pd05qV2E3aEFhNEowZFl6VHJPcTdITzBnNTBFNkVo?=
 =?utf-8?B?YUR5M0xsR1F2aHVTeE1pTVhOZjhrS3V6YVFMSXVaWlRSUnZhL0lUU0hYY0J3?=
 =?utf-8?B?SUZsOHBKbTFHR3A3RE40MlFKQ0FiOVVRYlBNTjRVODFCZGp1akFlWmNrQXg4?=
 =?utf-8?B?cWxEcGdjTlBncTc3cksxWC9SdGdNTUt1V0FNUVh2bVIyUW5NOVRxRWZqcmFu?=
 =?utf-8?B?ZkNkS2ZMellhNS9TdVlDSzhHSW5tamZUL09ZUFRSajJiMDIxREJtNnE0anQv?=
 =?utf-8?B?VUdyRkVMblkrWkhVZ0Zicmh1UjRBeFp1WlBQa3JjQU9MTVhUdWZVWEl0SE1K?=
 =?utf-8?B?QkVWeVVzcnFEUGtYUHk3c2J6TG5ucUNjemJuQlh2NEZsMERjZnFoUVI3V2V5?=
 =?utf-8?B?UHVuWnNwRnk1dzZVbGZJeTg4dG04cGREQ01EVHhZQ3VKQlRKcDB1TFlTbk4z?=
 =?utf-8?B?WVdZcGEyenlZUmFxV0ZHT2ZDOW00VVlZMnYzK1dPdm5YVlRQQ21qTTJleHdG?=
 =?utf-8?B?N20veVFmY1UvSVJMREhhdWcvRUgwUS9jcGNtM0FtVHZ4alJDSVhKY3c2V1ZY?=
 =?utf-8?B?YVFYVWsyMmFXSXpNSTdsS0lXeWJ6dFZzU1pHT0YrUGZCR0svVXRESWlmVTdW?=
 =?utf-8?B?dVc0Ris3WnhkVE9Gb3h4K2xQY2pUUWJhMWFaamdxa1Y3MktzemV0Q1JYMDJD?=
 =?utf-8?B?b0R4ZTBSY1R6Sm9XUW1reU4xZnVscXd1bzVzWnhFWWlkLzJDc0VGK2RJa1ZG?=
 =?utf-8?B?cGJKSEh0RUMycjljeDhKbW9va2lyeXJGaGpDbWdmNmZrR0ltMWNFT2pLUGI4?=
 =?utf-8?B?aXcreFBuOHBhNVIvZ21sSlNPeFJNb0k0clYxRE91S1VzUzJuMGJkZWRPUnBM?=
 =?utf-8?B?ekNZZHJNUnEra1BOa2lRdklkV0kxNmY0WkNHeVVCWmtQbGg2c0tZMWlnc0Ux?=
 =?utf-8?B?MURsMFo4NmZFS09tczNaVEF1RGJVQUgyRU9XMEZMTG02QldjTXZpcE1reW1Q?=
 =?utf-8?B?dm51TzB3cFJIbHZiK0hQQ2k2bXVEVkZENnZyUSt3UnZpeFpmRk9qbWt6SXFY?=
 =?utf-8?B?UkdxNmNTdnFpMGQ1NDF0d1Q2aUVqY1AvalcwT3YyUGZwTFV3TjdUT1Vidm1G?=
 =?utf-8?B?TjBvYWFYYmhoZXAxVTlkaEp0clgxTVAxa0tOeGx1TnpOQlBSRVRJR3RIdGVF?=
 =?utf-8?B?ZGtHTk9nblYwQW5SZEZ1T3VuY1h1WHVuWk1tbGlCdTU2UWFBVWZPdWZuY1Zm?=
 =?utf-8?B?bk9DcE55bFhBS01RYmNpSUVoV0xDc2ZpMHpWZzNZSGRQWFI0T21sU01aR2xm?=
 =?utf-8?B?N0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dea637b-41c6-43d1-c7eb-08dc1d0022e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 17:16:00.2054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pVkad6H2ITuWe4aE6C8ZNLGghBZDkUoMYTA3ABYyeMguFCD3LQRjmL8BZbLBmkbEaj1aC6HpZPloVnJ10d/ICni99hHApSGF3hphRj3eKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1053
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <504F77545CBD724389C7270E93DE7AE5@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkgU2ltb24NCg0KU29ycnksIEkgbWlzc2VkIHRoaXMgb25lLCBhbHNvIGR1ZSB0byBhIGxvbmdl
ciBYbWFzL05ldyBZZWFyIGFuZCBsYXRlciBza2lpbmcgdmFjYXRpb24uDQoNCk9uIFN1biwgMjAy
My0xMS0xMiBhdCAxOTo1OCAtMDcwMCwgU2ltb24gR2xhc3Mgd3JvdGU6DQo+IEJvYXJkcyBjYW4g
dXNlIGEgc3lzaW5mbyBkcml2ZXIgaWYgYSBwYXJ0aWN1bGFyIG1vZGVsIG5hbWUgaXMgbmVlZGVk
Lg0KDQpPa2F5LCBidXQgc28gZmFyIHdlIGRpZCBwcmludCBtb3JlIHRoYW4ganVzdCBhIG1vZGVs
IG5hbWU6DQoNCk9uIEFwYWxpcy9Db2xpYnJpOg0KDQpNb2RlbDogVG9yYWRleCAwMDI4IEFwYWxp
cyBpTVg2USAyR0IgSVQgVjEuMUQNClNlcmlhbCM6IDEwODY3NDk5DQoNCk9uIFZlcmRpbjoNCg0K
TW9kZWw6IFRvcmFkZXggMDA1OCBWZXJkaW4gaU1YOE0gUGx1cyBRdWFkIDRHQiBXQiBJVCBWMS4x
QQ0KU2VyaWFsIzogMTQ3NzI5MTMNCkNhcnJpZXI6IFRvcmFkZXggRGFobGlhIFYxLjFBLCBTZXJp
YWwjIDEwODcwMzE2DQoNCk9wdGlvbmFsbHkgdGhlcmUgd291bGQgZXZlbiBiZSBkaXNwbGF5IGFk
YXB0ZXJzIHdpdGggcG90ZW50aWFsbHkgbW9yZSBtb2RlbCAoc2VyaWFsKSBpbmZvcm1hdGlvbi4N
Cg0KTm93IHdpdGggeW91ciBjaGFuZ2Ugd2UgZ2V0IHRoZSBmb2xsb3dpbmc6DQoNCk9uIEFwYWxp
cy9Db2xpYnJpOg0KDQpNb2RlbDogVG9yYWRleCBBcGFsaXMgaU1YNlEvRCBNb2R1bGUgb24gQXBh
bGlzIEV2YWx1YXRpb24gQm9hcmQNCk1vZGVsOiBUb3JhZGV4IEFwYWxpcyBpTVg2IFF1YWQgMkdC
IElUDQpNb2RlbDogVG9yYWRleCAwMDI4IEFwYWxpcyBpTVg2USAyR0IgSVQgVjEuMUQNClNlcmlh
bCM6IDExMjExMDczDQoNClRoZSBmaXJzdCBsaW5lIGdldHMgcHJpbnRlZCBmcm9tIHRoZSBpbmZv
cm1hdGlvbiBpbiB0aGUgZGV2aWNlIHRyZWUsIHRoZSBzZWNvbmQgTGluZSBmcm9tIHRoZSBmYWxs
LWJhY2sgaW4gb3VyDQpib2FyZCBmaWxlICh3aGljaCBzbyBmYXIgd2FzIG9ubHkgdXNlZCBmb3Ig
dGhlIGNhc2Ugd2hlbiB3ZSBmYWlsZWQgcmVhZGluZyB0aGUgQ29uZmlnQmxvY2spIGFuZCB0aGUg
dGhpcmQgYW5kDQpmb3VydGggbGluZXMgYXJlIHRoZSBwcmV2aW91cyBpbmZvcm1hdGlvbi4gVWds
eSwgYnV0IHNvIGZhciBzbyBnb29kLg0KDQpPbiBWZXJkaW46DQoNCk1vZGVsOiBUb3JhZGV4IFZl
cmRpbiBpTVg4TSBQbHVzIFdCIG9uIFZlcmRpbiBEZXZlbG9wbWVudCBCb2FyZA0KDQpIZXJlIG9u
bHkgdGhlIGRldmljZSB0cmVlIGluZm9ybWF0aW9uIGdldHMgcHJpbnRlZCBhbmQgdGhlIENvbmZp
Z0Jsb2NrIGlzIG5vdCBldmVuIHJlYWQgYXQgYWxsIHdoaWNoDQpzdWJzZXF1ZW50bHkgZmFpbHMg
ZGV0ZWN0aW5nIHRoZSB2YXJpYW50IChlLmcuIFdpLUZpIHZzLiBub24tV2ktRmkpIGFuZCBsYXRl
ciBFdGhlcm5ldCBmYWlscyBkdWUgdG8gYW4gaW52YWxpZA0KTUFDIGFkZHJlc3MuIFRoaXMgZG9l
cyBub3QgbG9vayBnb29kLi4uDQoNCkFueXdheSwgSSBkb24ndCBwcm9wb3NlIHRvIGp1c3QgcmV2
ZXJ0IHlvdXIgd29yayBidXQgaW5zdGVhZCBsb29rZWQgaW50byBjb252ZXJ0aW5nIG91ciBwcmV2
aW91cw0Kc2hvd19ib2FyZF9pbmZvIChub3cgdGR4X2NoZWNrYm9hcmQpIHRvIGEgcHJvcGVyIHN5
c2luZm8gZHJpdmVyLiBUaGUgYmFzaWNzIGFjdHVhbGx5IHdvcmtlZCBxdWl0ZSBzbW9vdGhseSBi
dXQNCndlIHdvdWxkIG5lZWQgbW9yZSB0aGFuIGp1c3QgU1lTSU5GT19JRF9CT0FSRF9NT0RFTCwg
anVzdCBsaWtlIHlvdSBkbyB3aXRoIENPTkZJR19TWVNJTkZPX0VYVFJBLiBPZiBjb3Vyc2UsIEkN
CmNvdWxkIGp1c3QgZG8gYSBDT05GSUdfU1lTSU5GT19UT1JBREVYLCB3aXRoIGUuZy4gU1lTSU5G
T19JRF9CT0FSRF9TRVJJQUwgYW5kIG9wdGlvbmFsbHkNClNZU0lORk9fSURfQk9BUkRfQ0FSUklF
UiBvciBzb21ldGhpbmcgYnV0IG1heWJlIGEgbW9yZSBnZW5lcmljIHdheSBvZiBleHRlbmRpbmcg
c3lzaW5mbyB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UuDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQo+
IFVwZGF0ZSB0aGlzIGJvYXJkIHRvIHVzZSBjaGVja2JvYXJkKCkgZGlyZWN0bHksIHJhdGhlciB0
aGFuIGhhdmluZyBhDQo+IHdlYWsgZnVuY3Rpb24gbGFpZCBvbiB0b3Agb2YgYSB3ZWFrIGZ1bmN0
aW9uLg0KDQpVbmZvcnR1bmF0ZWx5LCBhcyBtZW50aW9uZWQgYWJvdmUsIHRoaXMgZG9lcyBub3Qg
cXVpdGUgbGVhZCB0byBhbnkgZGVzaXJlZCBiZWhhdmlvdXIuDQoNCj4gTWFrZSBhbGwgdGhlIGNo
ZWNrYm9hcmQoKSBmdW5jdGlvbnMgY2FsbCB0aGUgbmV3IHRkeF9jaGVja2JvYXJkKCkgc28NCj4g
dGhhdCB0aGUgc2FtZSBpbmZvcm1hdGlvbiBpcyBkaXNwbGF5ZWQuDQoNCk5vdCBxdWl0ZS4NCg0K
PiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+
IA0KPiDCoGJvYXJkL3RvcmFkZXgvYXBhbGlzLWlteDgvYXBhbGlzLWlteDguY8KgwqDCoMKgwqDC
oMKgwqAgfCAyICstDQo+IMKgYm9hcmQvdG9yYWRleC9hcGFsaXMtdGsxL2FwYWxpcy10azEuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiDCoGJvYXJkL3RvcmFkZXgvYXBhbGlzX2lteDYv
YXBhbGlzX2lteDYuY8KgwqDCoMKgwqDCoMKgwqAgfCAzICsrLQ0KPiDCoGJvYXJkL3RvcmFkZXgv
YXBhbGlzX3QzMC9hcGFsaXNfdDMwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gwqBi
b2FyZC90b3JhZGV4L2NvbGlicmktaW14NnVsbC9jb2xpYnJpLWlteDZ1bGwuYyB8IDIgKy0NCj4g
wqBib2FyZC90b3JhZGV4L2NvbGlicmktaW14OHgvY29saWJyaS1pbXg4eC5jwqDCoMKgwqAgfCAy
ICstDQo+IMKgYm9hcmQvdG9yYWRleC9jb2xpYnJpX2lteDYvY29saWJyaV9pbXg2LmPCoMKgwqDC
oMKgwqAgfCAzICsrLQ0KPiDCoGJvYXJkL3RvcmFkZXgvY29saWJyaV9pbXg3L2NvbGlicmlfaW14
Ny5jwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiDCoGJvYXJkL3RvcmFkZXgvY29saWJyaV90MjAvY29s
aWJyaV90MjAuY8KgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+IMKgYm9hcmQvdG9yYWRleC9jb2xp
YnJpX3QzMC9jb2xpYnJpX3QzMC5jwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gwqBib2FyZC90
b3JhZGV4L2NvbGlicmlfdmYvY29saWJyaV92Zi5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICst
DQo+IMKgYm9hcmQvdG9yYWRleC9jb21tb24vdGR4LWNvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDIgKy0NCj4gwqBib2FyZC90b3JhZGV4L2NvbW1vbi90ZHgtY29tbW9uLmjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMSArDQo+IMKgMTMgZmlsZXMgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoNCltzbmlwXQ0KDQoNCkNoZWVycw0K
DQpNYXJjZWwNCg==

