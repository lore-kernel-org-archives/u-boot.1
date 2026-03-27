Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E8D10F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D30840B0;
	Fri, 27 Mar 2026 17:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="S8sz2Ofl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBC083DA7; Fri, 27 Mar 2026 14:48:55 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 081B48394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF+gK+7wRq7B/IOZwkY/XasS/foo/bFxfAboUYiWJSRpj9USjpAsMvouAtzvdYygsqcUM9KRVPos5mNiyD6QN3Y3BPm+gmXXR1N+A1ixcO/fgZHQM5RyTgdVwpaBGD+ET4xKaU/tZbtYQj3RKCsJTSjcZDFjCq+6eXrcHc5WvrgU9X/KAwoVeXveN0opyXJlEbu9ld8IoPRVDw7PB0WlKpUS0upmTYAPdCo1wEdXSbKAa7W/1ffqr/MiktDbeRwOvVsfuHeM7vItafFfbMfqwp9SiX8xaKHGO6pH7k/3qyUtuj9A31Gq0r4f6oF5Pi+nj3hDO8U6C14RqqRO+Y5X2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtv7NUME6zinq4qp5wbJtqfFTvhAXC7dXgjNdm34FPs=;
 b=JdfHfOPVSBV6TkxqKHEOTJJvuDasc5UHmmWSo2TV5KdzgPuIAhQhGKIY9jGFIKpLfJ1p+ftZkaXNjYzwbuTZNFcbNotP+vqoP9Dvv7PAcDQOKurzAkh3BPyZFXlMQTVnHfRwtokQPw16zG9pOMIiEto76MdMXHHNkS94K9FyUKn26Dzg7q4nmgg03iCfedb/wxurBJ4Bcp+rRxEpAS5ZwG6Q2IvaEYldB39Y25vQ+hoGxHqw1nBhP3QpdYZRTFpwscLbkBv6yDCC2NUwxP8mtvPouCaljbQE1OS+msdd4hXB5tcTGKM9+zFEpxOeP+2Lx558GuuDQFu5hwbEq49jrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtv7NUME6zinq4qp5wbJtqfFTvhAXC7dXgjNdm34FPs=;
 b=S8sz2Oflncctbul7JQ4TY4LsY2kYt/pbZYzHZddVUEnZId5q7RQRIc6Fj9AdrqzuMAi0/ZAQ7GLL6bjTzzh49Bdvq0Q+uMIeKDQuSgs5Eog7QRJ+8yiwCJXCvFEwhZH3KvEnwH4Un1y37iiKqYCYClzY1yLsM1LE2PupSWLgwHXrpDsGp2t5vXrscXuruAz8ht8r9B2oIpHWbnhwSDKHcelm+CFVeYLlWF0c+BQa75AweB4TZkdGRWDUrTVFQ4lznlF1qKh/1B8gB9cGFFc12iXJaxr6FOmLwUSQCU/VSIrpnFK/TtgpztTrhobE6nSvQ9TR8MzL0uEFyBnfm2gpNw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by GV4PR09MB8459.eurprd09.prod.outlook.com (2603:10a6:150:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 13:48:48 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 13:48:48 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Conor Dooley <conor@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 2/8] board: boston-riscv: Add initial support for P8700
 Boston board
Thread-Topic: [PATCH v5 2/8] board: boston-riscv: Add initial support for
 P8700 Boston board
Thread-Index: AQHcdOxfRUWza4oSX0yckh0yN6pimrW0p2EAgA5PpQA=
Date: Fri, 27 Mar 2026 13:48:48 +0000
Message-ID: <920f1a40-d70e-4dbc-b1ea-254f786c2773@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-3-uros.stajic@htecgroup.com>
 <20260318-moocher-cupbearer-bfbe474d8d55@spud>
In-Reply-To: <20260318-moocher-cupbearer-bfbe474d8d55@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|GV4PR09MB8459:EE_
x-ms-office365-filtering-correlation-id: d47e633f-a0dd-4d89-bc66-08de8c0792c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: VkugJ9YlXBYCAC8kamqtfv2Sq7e6tqkSYAkoSKBYsxUUuGivkcuCsHVYhxAnVN/zkFOqFA4QTEYUdOFuGJkROH9hFhRNFH4uM+prAWXXykgOfap2Hhc6WqY0rkb5ZV3ESt47E2cJTH094SOwi3f5CjhifLvT56gZB1UvnjyEAAkziW4hpGVffnrHMWTXQBTaY1lvbZB5FcNfAGiy43/KfE9xGoNRMDr9JC2MXHCcN2CMyGUOhwOaOB0wJEFePJaCrizRrgtO5n73O6eQM4evrlU9eskOE6+latFRtUd+yM1DsmOXHscC0w99gwxxojxpdFTSw3lr68tmibpbulykFAjgxDJjXtyRIaen1ZiEl10+boNXra+ZKTjDky7sHRA5Usx0+f5/x0Ie/+g955CpwbiNx4cUS9ly2/LxcIwet+pWIDPXfdfR+NMkvmyf48PhFAimE05Jrq5LMb6bPfW/Tiv2iryEnqxAx4Van5jGs3iz6nqnKEEPHcxm0fUSdn0JSv8epRoj/ihvFI9a2iVaYyOIfwKtMzHomXJujlK3p1Jt3y08XJcZJERfZ/UhcAoRj7BHgaL/CrvFusiOEYXrMSJwZMyJWeQ7TRR0zGr86YRRtopaxjyivh/SysEfWyPxosshqlfjdZYsYNgVUt8yG1CqqswVR/CvFZUeVcimgaMDRMAzQtQNfvC6tAvvrHlXhM+y0LgOylNa09KCvwXsoMjNAIjVXfP+vAExZ/ziEek47ZzSMMx018cq10sZCiYG9FsC7TXaWM/mki1/PKInBb0u0Y82wk0JpJJxaeMvJ9Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVUwdlBQZTF1b2FsU2F2dWpxTlVELzVrOVlGbVJwY2hIRXZVMnJXK0xpckxU?=
 =?utf-8?B?ZG14SkFTYVhLWk1rRm1VSDNBcTM5b2VvNFFJUUExNVlXN0d3S3dMSWU5M2ZX?=
 =?utf-8?B?ZTh1STlGWFhFOE1mQmp0N2Y0V0htamxSbndwMVo4R1FGdVFubEJRRHd0elI5?=
 =?utf-8?B?MkxBZE1yZTIxdGtIcldyak1ucExwWXUySDNBZnhNTVhYN3VFMGpLYlpZRGxY?=
 =?utf-8?B?Wi94WGp2U3ZYeWJSYVpXT1NjVFVKQ1pDdGJoTDVRMWhxUHdhYm0rTkd4TGxE?=
 =?utf-8?B?a2NldGNmS3h1aGhmUjFBTE5RSDdHZWRoRzZSOE8wMWtiWFpSd2lQTGpKNXVQ?=
 =?utf-8?B?TVFWYngwQXNhRytTc2R2YmVkVTk3VFJ6aXVjc3NwVzdSa3RvemhneGtqVkZq?=
 =?utf-8?B?eG1ramc3dHpwTWhoU0RjTVlFVUxLSTFhVnQ5Y213K2RNWklvQzdENUp6WjZu?=
 =?utf-8?B?MEtxYm5XOFpSVzhGTFhuWWJ2aUc1dklJZllLSDZRdzlJYUh6ZWFEUHl5WjhR?=
 =?utf-8?B?Zk5iZEI2QU83RjRhbEdKMkVHU1IwbnB6QzY0NjE2MTZFemllZlFEaHlKV0hw?=
 =?utf-8?B?K2N2Wjd1YzBJVWE4MW1FcERyTmkzK3ZmNEVTSGM5Q0NaUjVjcGd1ZVpTb3JO?=
 =?utf-8?B?Z000cFdGNVhkeld5RTRFbFZTTUdaZWx2SmJkNlI4b2lhajlOZVByYXQ2eUVY?=
 =?utf-8?B?R3hlMEZ0TG9YTDlCc0Y0emZCZEkrbFNQMWVtUXVOVjZSbTZUYmNEMmw1bHdK?=
 =?utf-8?B?cXpETlhYYXE1d0Z4S0R6dzdLZW42UzZWaHNza2kxQUYwZEZMRVhZTWswZUoz?=
 =?utf-8?B?anhvQytRKytGdU9naFk0N1ZCRkYrM2N6a29zRVU0UHVEUk1PNjFwTmh1aVNa?=
 =?utf-8?B?T0M3YTBibFZYSHFjdHNkcjViL2xKOUlzL0FVVEl1c1NjRk1SWGhWMG92WWxs?=
 =?utf-8?B?UGYxdDg3MzFvQkswQnUxS2RzR0RQcldwMGxHQlg3YTBTTkxHYWpVQTluZXg1?=
 =?utf-8?B?N3ZDWTlCS3RtaUx4VVQzUWM1VzVqSW8zQnQ4L3l6bnBGR2FDU1hQMmJPMStj?=
 =?utf-8?B?YUQ3MFExbEcwVStzV3hsOXBET2pGQ1doU3FvbmVZd09aekNTTnAxM1VONU0r?=
 =?utf-8?B?NjcwakFvMjhOT2RHcStXOWRtWjVMT3E1dG5UV1NlVFprL2ZnWGdrUE11Um1P?=
 =?utf-8?B?YnAvRjQ0OUNPVHhzUEQ0aXh2cHhydXNxZmtMMDczZFFBbU5zOVNtWlM3WVM4?=
 =?utf-8?B?RnZLSUdRSjFqNWFOV3J4MGgvdkQ0UnhUeHRzb0tmVlAwek85NEhVbkIxc3R4?=
 =?utf-8?B?dEhNeHZpdGluZWdBeDBzVFljZWkrYU1RbnA2L2J2c2Y1UjF2T1pyeUttL013?=
 =?utf-8?B?MHluRHFyRGltdG9MMVhDZXErZWU5MDA3S0pvc0pFUlJqL2tTZzdkODJ2eE9q?=
 =?utf-8?B?U1hXMTNSZ3k3am5CVkVmYWtrUExPTFUzdTVRa2JETjZwWXJwU3JjTDBkQk1W?=
 =?utf-8?B?dkdUZXFLQVBmQ2lsV3RORVpVWTgySWl0MTdxNU5OQlNqbE1zWitzMVJMaDRq?=
 =?utf-8?B?bTlKeURQSXZ2ZWhPQmNvKzBncTJzb3VKcGhaTVhDSFJMOWhKcng3K2x1eDdE?=
 =?utf-8?B?NjREUTFub214UVlpcjRxR2dUTlNkekJkNk9RY0xwYWg3WVJYaXJDZSthamph?=
 =?utf-8?B?NU0xM2tlOGtCWUJmWkJhdng0ZkNsbWl3eElVV0JTZk9iR3FWZ2VldGVaL0JV?=
 =?utf-8?B?SjB3SkNQbkYxUFI3UzVqSHUrSGFnRFVCc0dvMk5KQnpEMEdwWWJpVU5kbmVL?=
 =?utf-8?B?RmRDeWg0QnlkVW5zRjhCbmUra3gydUZmWnhwbDczZnpHblpMY0VyaWZ6T3V6?=
 =?utf-8?B?enM4TERGZ1FnY0hWOWJYczlJUS84ck1VK0twd0c3Z1NMZlVHSTF0NUwwRDdj?=
 =?utf-8?B?NWhXTU95UUJ1Wk04bGtpN1BCU1FTdlp3dWNSWGJLTHJ5Tzd5WkIxT0k2QjFP?=
 =?utf-8?B?Uzk5cmgwVlpOd0NrdGx5VlVMSVBLNkhGOTErUDROQW53RVBnM2tHdVZMUkJ0?=
 =?utf-8?B?aGZaSDRZTWc2VzQ0b3h0UVRsNyt5QUxlUmtEa3ord3QxOUZtT1d3dm14b3NW?=
 =?utf-8?B?MThxWkVuVDRpejZlMFpDcjhrZ1lNQVdtdUx6alRzT1lGUXJMUmgwL3ZxYkVB?=
 =?utf-8?B?dXNsMDJmTjgzcmtRWm1qRTdNQzkzc2JOQXNPNlp4OW5kOUxKU2NIWnFsUllS?=
 =?utf-8?B?d0JLdmdtcDZNZGN0dVNwYW81RGhiSkRxSUxZbUlTMnBzRW9RVWxWcHJsbFVv?=
 =?utf-8?B?NHFranZiRXNuZ3FOWmFRU29IS1hQck1Fci9tR0hQaDJSbmNyS2lJdzdOSzN1?=
 =?utf-8?Q?zOuqZrZ4gkV/3T0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6571D68948D3964AA74F3C80C831FE94@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47e633f-a0dd-4d89-bc66-08de8c0792c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 13:48:48.7672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BDDWUULwgiePMD+wFyA9pes2iK1T/9Mh6wyGSmWqN8JNIUZCH9zxfYSnrc0G4pZM7kODlmqAEUPr3PkSkMjBDnVHy5jeXHMxtUfPKLyb68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR09MB8459
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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

SGkgQ29ub3IsDQoNCk9uIDMvMTgvMjYgMTI6MTYsIENvbm9yIERvb2xleSB3cm90ZToNCj4gT24g
V2VkLCBEZWMgMjQsIDIwMjUgYXQgMDM6NDU6NDdQTSArMDAwMCwgVXJvcyBTdGFqaWMgd3JvdGU6
DQo+PiBGcm9tOiBDaGFvLXlpbmcgRnU8Y2Z1QG1pcHMuY29tPg0KPj4NCj4+IEltcGxlbWVudCBp
bml0aWFsIGJvYXJkLWxldmVsIHN1cHBvcnQgZm9yIHRoZSBQODcwMCBCb3N0b24gU29DLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdTxjZnVAbWlwcy5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBVcm9zIFN0YWppYzx1cm9zLnN0YWppY0BodGVjZ3JvdXAuY29tPg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3YvZHRzL2Jvc3Rvbi1wODcwMC5kdHMgYi9hcmNoL3Jpc2N2L2R0cy9i
b3N0b24tcDg3MDAuZHRzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMDAuLmYyN2ViZWRhNGEyDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNoL3Jpc2N2
L2R0cy9ib3N0b24tcDg3MDAuZHRzDQo+PiBAQCAtMCwwICsxLDI2NCBAQA0KPj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPj4gKy8qDQo+PiArICogQ29weXJpZ2h0IChD
KSAyMDIxLCBDaGFvLXlpbmcgRnU8Y2Z1QG1pcHMuY29tPg0KPj4gKyAqLw0KPj4gKw0KPj4gKy9k
dHMtdjEvOw0KPj4gKw0KPj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9ib3N0b24tY2xv
Y2suaD4NCj4+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPj4gKyNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9taXBzLWdpYy5oPg0KPj4gKw0KPj4g
Ky8gew0KPj4gKwkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJI3NpemUtY2VsbHMgPSA8MT47
DQo+PiArCW1vZGVsID0gInA4NzAwIjsNCj4+ICsJY29tcGF0aWJsZSA9ICJpbWcsYm9zdG9uIjsN
Cj4gVGhpcyBpcyBub3QgYSB1bmlxdWUgaWQsIHRoaXMgaXMgdXNlZCBieSBhIG1pcHMgbWlwcyBi
b2FyZCBhbHJlYWR5Lg0KPiBJIHRoaW5rIHRoZSBvbmUgdGhhdCBpcyBiZWluZyB1c2VkIGluIG9w
ZW5zYmkgaXMgbWlwcyxwODcwMC1ib3N0b24uDQo+IA0KPj4gKw0KPj4gKwlhbGlhc2VzIHsNCj4+
ICsJCXNlcmlhbDAgPSAmdWFydDA7DQo+PiArCX07DQo+PiArDQo+PiArCWNob3NlbiB7DQo+PiAr
CQlzdGRvdXQtcGF0aCA9ICJzZXJpYWwwOjExNTIwMG44IjsNCj4+ICsJfTsNCj4+ICsNCj4+ICsJ
Y3B1cyB7DQo+PiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJCSNzaXplLWNlbGxzID0g
PDA+Ow0KPj4gKwkJdGltZWJhc2UtZnJlcXVlbmN5ID0gPDI1MDAwMDAwPjsNCj4+ICsNCj4+ICsJ
CWNwdUAwIHsNCj4+ICsJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOw0KPj4gKwkJCWNvbXBhdGlibGUg
PSAicmlzY3YiOw0KPiBUaGVyZSdzIGEgc3BlY2lmaWMgY3B1IGNvbXBhdGlibGUgZm9yIHRoaXMg
bm93LiAicmlzY3YiIGluIGlzb2xhdGlvbiBpcw0KPiBvbmx5IGZvciBxZW11IGV0Yy4gT3BlblNC
SSBhY3R1YWxseSB3YW50cyB0aGUgc3BlY2lmaWMgY29tcGF0aWJsZS4NCj4gDQoNClRoYW5rcyBm
b3IgdGhlIHJldmlldy4gSSB3aWxsIHVwZGF0ZSBib3RoIGNvbXBhdGlibGVzIGluIHRoZSBuZXh0
IHJldmlzaW9uLg0KDQo+IENhbiB0aGlzIGJlIHNlbnQgdG8gTGludXgsIHNvIGl0IGNhbiBnZXQg
bW9yZSBleWViYWxscyBvbiB0aGUgZHRzLCBhbmQgdXNlDQo+IE9GX1VQU1RSRUFNIHRvIGltcG9y
dCBpdCB0byBVLUJvb3Q/DQoNClllcywgd2UgYXJlIHBsYW5uaW5nIHRvIHN0YXJ0IHRoZSB1cHN0
cmVhbSBwcm9jZXNzIG9mIHRoZSBEVFMgZmlsZSwgYW5kIA0Kb25jZSBpdCBpcyBtZXJnZWQsIHdl
IGNhbiBpbXBvcnQgaXQgaW50byBVLWJvb3QuDQoNCkJlc3QgcmVnYXJkcywNClVyb3MNCg==
