Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB632CE8D61
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A67890F7;
	Thu, 19 Sep 2024 11:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vqa8r2+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C8F88B3F; Thu, 19 Sep 2024 11:21:27 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AB9890FE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjHup9m8gtF2Vv/Bbnae7B054m5ZKn+lZB8Onsulzl+g0hyfRCjbI8RKzfOE9UlcE+Tv/mr40LyqJd9JUGaaU+qyeZJEiWg0hMaCBRCy5IkMeWW/z3W6eA6pvziUidGdKrHnQ29qaedkudvZOXhnjkKE25gGADGDuFzNv1waDSoYoMDu8w3Yg7LdQMG49AtShkqSojYlEEi8KPrBp9FdmNGBwr0lttvTFn6aAOq26Bnbbi9qqQ61w20os1jjjUsxxy5vRiPfm8zRfUdOJzdNlMgNy0gNUg2J+P4n7186QHeD3x6sDyNpF+SONKuF1Q7kHrXOcjnBY00OEaY3GNI3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apEksq/iL8fSOXUsh39nMGGKOJ3RGQByymFzyODLdTE=;
 b=JMLPIZ7xXxf8XrLX8RmvCvdiZUkY21LAzxUYrbEGekAVuS77phkJXVLp4YBb3ykPJVOGHHAojLN+jyVPN30EmqyNkrGnZk4g0BFcmCPJpVpXhF6RFz8Vj3+q9xAkVN5j0bMcSU0tuD9PgRoq5uywVY7Kn75Yfu2YpB93dnZEQeCzGO7GGVRVe7Uc1692VDlNofLg5WVhI9IFkDLup0HKyact086uKpFzM5eWfnSqO+PAKq1r1su09fyxEagVqOMbFAXrlltvuLXs0czmnLuPuD3WSCR2TojLXx62PWt2C4DwqUziXtudsD8027vHYHWT1UiAyHjdiAjQtcAxk7+Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apEksq/iL8fSOXUsh39nMGGKOJ3RGQByymFzyODLdTE=;
 b=Vqa8r2+r9+mG0G3vmYIFUa2DmVQZlWv63TTcAVCkKiBFc8gUMfuyMirpn+Cq6UfMGdLN/kD2xC94J7CYGJbfLPiwfn71RXVdmsuG1vKrr20D4OLnI1bmLNvkOUalvUdxICiBX8fqoKmvMxAPxtwRHvJaLSv6UYT4oOHrNucJo8U=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 09:21:19 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 09:21:19 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "Simek, Michal"
 <michal.simek@amd.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Neha
 Malcom Francis <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom
 Rini <trini@konsulko.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "u-boot-qcom@groups.io"
 <u-boot-qcom@groups.io>, Bhupesh Sharma <bhupesh.linux@gmail.com>
Subject: RE: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
Thread-Topic: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
Thread-Index: AQHbCampdh8P/00k5kqn1EG07sxpc7JdWwkAgAAB44CAAWF3gIAAGAag
Date: Thu, 19 Sep 2024 09:21:19 +0000
Message-ID: <SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
 <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
 <79c51777-fbe0-4a02-9f81-bd468740ac6b@linaro.org>
 <69b3b92d-b263-40b1-8d39-66a5fb445015@amd.com>
 <7b71a9fe-946a-4b1a-bdc8-76050e1d8954@linaro.org>
In-Reply-To: <7b71a9fe-946a-4b1a-bdc8-76050e1d8954@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DS0PR12MB7656:EE_
x-ms-office365-filtering-correlation-id: b132a53a-a5fd-439c-8828-08dcd88c6bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UDNHaUdsQU0zMGxLdThLWkFzcnNMZFNLYkhJY1dQVmVrK1pGYW5RZlAzUTQz?=
 =?utf-8?B?Q2lpb3BnU1R5dDgrYk05dUxENzg1YkZIZzVWR1E3alZ1ZTk5d1BLZ3BpcEJR?=
 =?utf-8?B?NkxLTnlnMGluOTkxV2xkdkZpNmhlelY1ZllIZUx2REpORjc0aktMMmJ1a0tO?=
 =?utf-8?B?dXNLOXRpWXE5ODBleFltUklSZVovb09mc2RNMUk2WkViLy83WjVTOHVudmM4?=
 =?utf-8?B?VkEyS0RuemNMdXJoYTdtV1graDZxZEp0L0VseWUxN2s5SXlPNCtkUUUyMXpJ?=
 =?utf-8?B?cWxndmxxUXMwZEZjczBQd3V0ZTFNamJtb2RFcUc4MWFMR2pkUHhYNjQvTVA4?=
 =?utf-8?B?TWk4eFVnaEtYaE5NNzMzWTVrdm1BRTdlTnFXMTdMNkxQS3dUZmVuLzNCcldn?=
 =?utf-8?B?WDF1dGF6SnZzS3AvSEhJTnRWdVI5QlplbjByU25sblcxWkxvN2RJUFY1RlJX?=
 =?utf-8?B?b01Pd3NFb1lEbEJyOGgzb0owY2JvUnJlNGNhdzlDZWkweUVmYi9WT0hZSTJB?=
 =?utf-8?B?VmhjY3duMFE0c3dQMEM3WkxLZi8xOFVQY0dCV1pHMmtoeVZuaEo5S09TakEy?=
 =?utf-8?B?VWdHQlNRRkZ3cU4xbTJXQUIrNE9hNDJDRWtBNkZubzZDZFdhdC9WY1puNmFJ?=
 =?utf-8?B?ZWlmZGwraUFabGVqSHA1bHl6REppRXhra0lLZitONklDY1U0Ykl4blJGWG9k?=
 =?utf-8?B?dmpxVGRCdkgxSmRKdm11UlRBS3NlVkJabVBwMzd1YUVOWG9IS2prTjBkOFJX?=
 =?utf-8?B?emRBeFBhS3kxbWdNTTBKSm1PS05rRmExZ1FoNWRsbFU1Q2FhUnd4WnJLQUZR?=
 =?utf-8?B?R1oyaUZWbURZSTdWNWhxTFFXMFNNR0Y0cFdiTmdqWXZFN3FwNXNUbjZpOFhS?=
 =?utf-8?B?QUduMlZlZlpVc3RyYTJwV3Z0dHVzSmVjeHJTY0Vlckc4Rm1WUkZLMmxrVjho?=
 =?utf-8?B?R1A1TC9DWi8rMVZSalN1MkRZZDNEV0tUQ1VjS2F1TWVsTHN5Uk1ObjlHUVhZ?=
 =?utf-8?B?RGl6cndFUGFKR3crbm53ZkVDcTBpL1VoNHdzdU1LTnVpNUJwcTFrRTM1eWZB?=
 =?utf-8?B?U2JiTTAzcmlPSWlvcUorRGFMU0M3VzJwNmEydXRXOXg5YlhJdUtoRkRneTZx?=
 =?utf-8?B?RDlEdGJCTVl2QXFkcnFwUi85RWpGd0szSWFBcEZRcnZLbFhiMVRHZjVDN3gz?=
 =?utf-8?B?S0ZGT3ZTVWNoSlJIeGI4aHRmTWZLMEVDUG0vT0FMbjBZUkpUV29HMndKMlVp?=
 =?utf-8?B?VUU3NTJxLzRlbWhmQVVyMTlvaXQzdVVKK3VBYjZXUnFiL1lWMzBiazc3YUFu?=
 =?utf-8?B?cU8rSC9aQTV2UW1kR1ppTDc2RXJicHo2V29EZFhvek5EYmI2U1hEVjhKbmNo?=
 =?utf-8?B?TTE4bFJoRGxHdXdIQlA5SUhKS0JpWVNxSitNZExUWUlNU3ZZTDR3ZHNveTRX?=
 =?utf-8?B?WjdOUlJYUFg5OHdYUXdReTZhRWxxSmRRSUg5UXBGUGRlTVAyNHhsTVR4MDVL?=
 =?utf-8?B?V1ZNbERURDFlN1RyTVhtNGMxWGE2cGZUNng2SW9zcDF5WG1oeHNuSDJwMWVO?=
 =?utf-8?B?dVVsTnRDeXVxQ2pIZUUrV2VrSFM3emd0VHN0UXc0S3RMQzhwTWgxdDZ6a1Zi?=
 =?utf-8?B?OUNMVGNYTXZsYUZyb05GVkRPZGYwZmY2MnlWYVhMSjc3endUc0FiRitpMXRm?=
 =?utf-8?B?RmdLSmdlKytwM1RKc2V2S1FRM00zK1JyMFZvVkhDbVB1ZlJBamdiNWRsUUFn?=
 =?utf-8?B?YTlZZks3ZUZ1NFFIRC9SK3E0UzltNjcvcXRQZGhHdzZXV0JzY013WFg1dnlv?=
 =?utf-8?B?cUsycGEwd3MvMGoyWnRaS2g0SWtUZER2OFQ2T2U3U1ZqSjFMLzhaeTJiSmM1?=
 =?utf-8?B?djdmQlg5WVE0NlZ0TzFWVVVSZHArOUREdUZSQlo3VWZncXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzhRUGZ6bXhldkM2NkpUdTlNcU01VHhmTk0rZHFQdVJhb2MrN2lBK2EzRis2?=
 =?utf-8?B?UXRYM0hiUHRFSUFISFVlQ1VrSnFaVzY4d0VCRWtvUEpoUGFBMDQ2NUdJQnpm?=
 =?utf-8?B?d1lMVS9rb3RIVzhPT2FLWmUzZ2JtWndBVlRtNUNxbnRDZWRORmQxSmZ1R2F2?=
 =?utf-8?B?YVVDRXJDYkhNZCtYekphOXZzZk84eUtVd0lyRUUzRTJ3ZCt5TDI4eU9XZzc1?=
 =?utf-8?B?OWl5bmtJZ0hoTXpJTDJtenVBUk54L0tSWUY3NnVPVXdoMTNnN1pDemxFN3Va?=
 =?utf-8?B?d1BhcllEaGkrVnJLdTE5Tm9GTkRoUFVGc0c2cVNoYnVZN2xzaDd5UHVpc3hT?=
 =?utf-8?B?WHJtbjU4UE53akVsSUdhMGdhNXFIYUp3NVZZZmRIbEZhaVkvY1haVzdSYWNV?=
 =?utf-8?B?MXFqd1VrN0lKS0FmVUp4akROYUx3aXdvbFl1VmZQVkgyMHBHRHpQYjlsRldH?=
 =?utf-8?B?L3Fyd05WT2hXRm16aDh0Wmt6RGtaZG9MekJTcVVFTnE3SllibW81UCt1UVhz?=
 =?utf-8?B?ckErK2YxRFR4SHcwSzlIZVAzbEpQdWpnTW5tTDhQNHFkeXYyQjI0S25nOHNH?=
 =?utf-8?B?VTUvdDVBWXp5WklUY1VjTnNCT3FDVkpNRll1Wk1FVkxsSEwwak95dHJYajlZ?=
 =?utf-8?B?RjdlMnE1RnVaRDk0UkFFVk01SkxEc05yVDBvd253U3pZZFY4aHRPNnZNcWlT?=
 =?utf-8?B?bE1oVEVHSXZ6cTZHNThaK3BNR0x4TERvMXhDZGFFUW9yMzJqeFB2TXNxRG5L?=
 =?utf-8?B?djgrc3lVVUM4eXduN240VUdhWU5yaWNZUTRVM1l4NE9CSG5LeU9idEdKNkha?=
 =?utf-8?B?aDc4Z2tDZThKazVKaHVzZ3ZRUEVGcGM4NzBkNlZPOXk4bXo5YTdJQVo0R2l3?=
 =?utf-8?B?YVAxbExXTXVPS2tFeVZkRmcwYml2bFU3ZmlSZ3JUa3FWRy9UNlY2Qk1BcGdJ?=
 =?utf-8?B?d25OZWpBWlpZckdyVTFMSGFjS3dJZ1BmTXk5Yzh0Z3lOb3BVeTZjdDhCU0VC?=
 =?utf-8?B?b20vaUUwZ3hSekVnNjVRSkgwUFpRRDh4ZmRFaUlGdEtuQm5ZcVVzbFRBelBq?=
 =?utf-8?B?NkpBSEFMWXJDQ1B0U3A1SFd3bWVxMi9RMWM0M2theWxGU2twNnMraXQ2MW9n?=
 =?utf-8?B?ZFpFZTdndUdGa2JYbGRSTzlaTzM1SnhicUpHM2FwcHhkQ2hvVnlwRjFVdUtV?=
 =?utf-8?B?cEpJaFFrNWN4Mzd6NzFzSnR2blVPbDFiQmVPTUg2SkMyOGMrM3kwWmhtSEJR?=
 =?utf-8?B?MTc2Mys3VEZSRjAyY0hkc3J4cDJXa0JwajQzTithRkVNQ1NMQlRJSjdXc2N4?=
 =?utf-8?B?VzRETTd2TlBlSVJXVmtXVFBMMzhIbGZ2Sm4wSjgyTGFoSXJObndjSkpKUWs3?=
 =?utf-8?B?aWVuY1lJb0hqZWJKblM0cXBPZEYzSjg4U3RvZGE2NmM2TFBCUTdTNGdKR2lp?=
 =?utf-8?B?a1I3VnhSbjB4a2NKTXJJTkxleW0yYUl4MHV0bW8zYmRZNGZNUWtaMUNablht?=
 =?utf-8?B?cGFwQUk3NFljczlaSWxpK0ZNQWJTYjdZRGIzcllEQmNQSTM1N2dhQzJxOTlq?=
 =?utf-8?B?ZFU3QjBnWURVNHpqVWNWdEhMNXNJMDVid2xMeWxObnRmV1RiVmxJS1N3NlMy?=
 =?utf-8?B?OVZDWUhIT0hEdkxCT0QzRUhEUXpHYzJCeFZiVDBMaFBxdVp4N1dMOXJEYzNv?=
 =?utf-8?B?NlVsaWRMUEo4QlFFb0FPa25XREJIUGU5Wlk5VTJ0THJHOXBSbGNLYVFxTlps?=
 =?utf-8?B?OGw0aExjM0s5czlNOEx1R2I1cDB4QkgvbjkxM0UrYnhMcE1vQnpDWmJKUTUz?=
 =?utf-8?B?cTdYWlVCaEdnbDVzcmJQRzJJWUdudSttd1QrWHlGSEkzVXBIalVZSG5LcGx4?=
 =?utf-8?B?UjVrS2M3Zmp1eDNmR0lmSGlXaDlHbi9JUXh5NGo1azFLa0VXbHFFQmRoVVdW?=
 =?utf-8?B?OUFwTW9HWjI2aUozSk5zVmpUdVI1UisxMGR4R21mNFZybG5iSmcvZkVKOGJQ?=
 =?utf-8?B?WEFUYTZpYVROTGgrQnMxUFlWbS8rdkpnNmxkbW5uMEw1UEM0cE1BSlJXSDUw?=
 =?utf-8?B?bmQ3eWs4MWxlMjNiZHJzV1cxQmdlTm0za0F2b0ZqTHFKdHd5WlR4SlNPS2d2?=
 =?utf-8?Q?PpOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b132a53a-a5fd-439c-8828-08dcd88c6bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 09:21:19.3979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSIUwE8zUfIegScvj9rxggW7lkowL4O86HmcpaTr1lJaXIGi2cl4MINc4HFNCqTDoO+bc+4NYBqAMLkm4iHjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmVpbC5hcm1zdHJv
bmdAbGluYXJvLm9yZyA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIFNlcHRlbWJlciAxOSwgMjAyNCAxOjIyIFBNDQo+IFRvOiBTaW1laywgTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IE1hcmVrIFZhc3V0DQo+IDxtYXJlay52YXN1dCtyZW5lc2FzQG1h
aWxib3gub3JnPjsgTmVoYSBNYWxjb20gRnJhbmNpcyA8bi1mcmFuY2lzQHRpLmNvbT47DQo+IE1h
bm9yaXQgQ2hhd2RocnkgPG0tY2hhd2RocnlAdGkuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1
bGtvLmNvbT47DQo+IGJtZW5nLmNuQGdtYWlsLmNvbTsgQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVu
a2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdS1i
b290LXFjb21AZ3JvdXBzLmlvOyBCaHVwZXNoIFNoYXJtYQ0KPiA8Ymh1cGVzaC5saW51eEBnbWFp
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTNdIHVmczogZW5oYW5jZW1lbnRzIHRv
IHN1cHBvcnQgUXVhbGNvbW0gVUZTDQo+IGNvbnRyb2xsZXJzDQo+IA0KPiBPbiAxOC8wOS8yMDI0
IDEyOjQ3LCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDkvMTgvMjQgMTI6
NDAsIG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmcgd3JvdGU6DQo+ID4+IEhpLA0KPiA+Pg0KPiA+
PiBPbiAxOC8wOS8yMDI0IDExOjAzLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+ID4+PiBIaSBOZWls
LA0KPiA+Pj4NCj4gPj4+IE9uIDkvMTgvMjQgMTA6MDYsIE5laWwgQXJtc3Ryb25nIHdyb3RlOg0K
PiA+Pj4+IEhpIE1hcmVrLCBNYW5vcml0LCBUb20sIE1pY2hhbCwNCj4gPj4+Pg0KPiA+Pj4+IE9u
IDEwLzA5LzIwMjQgMTE6MjAsIE5laWwgQXJtc3Ryb25nIHdyb3RlOg0KPiA+Pj4+PiBUaGlzIHNl
cmllIHJlZ3JvdXBzIGFsbCB0aGUgZml4ZXMgYW5kIGJhc2UgZW5oYW5jZW1lbnRzIHJlcXVpcmVk
DQo+ID4+Pj4+IHRvIHN1cHBvcnQgdGhlIFF1YWxjb21tIFVGUyBjb250cm9sbGVycyBpbiBVLUJv
b3QuDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoaXMgc3luY3MgaGVhZGVycyAmIGRlZmluZXMgZnJvbSBM
aW51eCwgYW5kIGluY2x1ZGVzIDIgc2V0IG9mDQo+ID4+Pj4+IGZpeGVzIHRoYXQgd2VyZSBzZW50
IHNlcGFyYXRlbHk6DQo+ID4+Pj4+IC0gdWZzOiBjb3JlOiByZW1vdmUgbGlua19zdGFydHVwX2Fn
YWluIGxvZ2ljDQo+ID4+Pj4+IC0gdWZzOiBwcm9wZXJseSBmaXggY2FjaGUgb3BlcmF0aW9ucw0K
PiA+Pj4+Pg0KPiA+Pj4+PiBXaXRob3V0IHRob3NlIDIgc2V0cywgVUZTIGNhbm5vdCBpbml0aWFs
aXplIG9uIFF1YWxjb21tIGNvbnRyb2xlcnMNCj4gPj4+Pj4gc2luY2UgdjUsIGFuZCBhIG51bWVy
b3VzIG9mIENhY2hlIGlzc3VlcyBtYWtlcyBhbnkgVUZTIGNvbnRyb2xsZXINCj4gPj4+Pj4gZmFp
bCB0byBpbml0aWFsaXplLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaW5jZSBVRlMgY29yZSBoYXNuJ3Qg
Y2hhbmdlZCBmb3IgYSB3aGlsZSwgYW5kIHNpbmNlIFVGUyBpcyBjb3JlDQo+ID4+Pj4+IHRlY2hu
b2xvZ3kgZm9yIHRoZSBRdWFsY29tbSBTb0NzLCBJIHZvbHVudGVlciBtYWludGFpbmluaWcgdGhl
IFVGUw0KPiA+Pj4+PiBzdWJzeXN0ZW0gaWYgQmh1cGVzaCAmIE5laGEgTWFsY29tIEZyYW5jaXMg
YXJlIG9rIHdpdGggdGhhdC4NCj4gPj4+Pg0KPiA+Pj4+IENvdWxkIHlvdSBydW4gdGhpcyBzZXJp
ZSBvbiB0aGUgcjhhNzc5ZjBfc3BpZGVyLCBqNzIxczJfZXZtX2E3MiwNCj4gPj4+PiBqNzIxZV9l
dm1fYTcyLCBqNzIwMF9ldm1fYTcyLCBhbWRfdmVyc2FsMl92aXJ0IGFuZCBxZW11LXJpc2N2IGFu
ZA0KPiBjaGVjayBmb3IgcG9zc2libGUgcmVncmVzc2lvbnMgPw0KPiA+Pj4+DQo+ID4+Pj4gSXQg
c2VlbXMgdGhlIG9ubHkgdXNlciBvZiBVRlNfUENJIGlzIHFlbXUtcmlzY3YsIGlzIHRoZXJlIG90
aGVyIHVzZXJzID8NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gR29vZCB0aW1pbmcuIFdlIGFyZSBjbG9z
ZSB0byBzZW5kIHNvbWUgdXBkYXRlcyB0byBVRlMgd2hpY2ggd2UgcmVxdWlyZSB0bw0KPiBnZXQg
RFdDIHZlcnNpb24gdG8gd29yayBpbnNpZGUgVS1Cb290Lg0KPiA+Pj4NCj4gPj4+IEhvdyBmYXIg
YXJlIHRoYXQgY29yZSBjaGFuZ2VzIGZyb20gTGludXg/IEkgc2VlIDkvMTMgaXMgc3luYyB3aXRo
IExpbnV4IGJ1dA0KPiB3aGVuIHRoaXMgaXMgZG9uZSB5b3Ugc2hvdWxkIGFsc28gc2F5IHdoaWNo
IExpbnV4IHZlcnNpb24gd2FzIHVzZWQgZm9yIHN5bmMuDQo+ID4+DQo+ID4+IEkgdGhpbmsgd2Ug
YXJlIHN0aWxsIHF1aXRlIGZhciBmcm9tIExpbnV4LCB3ZSBqdXN0IHRvb2sgdGhlIGJhc2ljDQo+
ID4+IHJlcXVpcmVkIGJpdHMgYW5kIHBpZWNlcyB0byBhdCBsZWFzdCBtYWtlIHRoZSBRY29tIFVG
UyBjb250cm9sbGVyDQo+ID4+IGRyaXZlciBidWlsZCB3b3JrLCBidXQgTGludXggZHJpdmVyIGlz
IG92ZXJseSBjb21wbGljYXRlZCB3aXRoIHBvd2VyIG1hbmFnZW1lbnQNCj4gY29kZSB3ZSBkbyBu
b3QgcmVhbGx5IG5lZWQgaW4gVS1Cb290LCBzbyBpdCdzIHF1aXRlIGhhcmQgdG8gc3luYyBob25l
c3RseS4NCj4gPj4NCj4gPj4gQnV0IHRoZSBwbGFuIGlzIHRvIGFsaWduIGFzIG11Y2ggYXMgcG9z
c2libGUgb25jZSB3ZSBnZXQgdGhlIGJhc2ljIFFjb20gVUZTDQo+IG1haW5saW5lLg0KPiA+DQo+
ID4gVGhhdCdzIHVuZGVyc3RhbmRhYmxlLiBCdXQgZXZlbiB3aGVuIHlvdSBzYXkgc3luYyB3aXRo
IExpbnV4IGZvciBzb21lIGhlYWRlcnMsDQo+IGV0YyBpdCBpcyBnb29kIHRvIHNheSB0aGF0IGl0
IGlzIHN5bmMgd2l0aCA2LjExIGZvciBleGFtcGxlLg0KPiANCj4gT2ggeWVzIGV4YWN0LCBJIGZv
cmdvdCB0byBhZGQgdGhpcyBpbmZvLCBJIHBsYW5uZWQgdG8uLi4gSSdsbCBmaXggdGhpcyBpbiBh
IHYyLg0KPiANCj4gVGhhbmtzLA0KPiBOZWlsDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IE1p
Y2hhbA0KPiA+DQpUaGVzZSBjaGFuZ2VzIGFyZSB2ZXJpZmllZCBvbiBBTUQgcGxhdGZvcm0gKGFt
ZF92ZXJzYWwyX3ZpcnRfZGVmY29uZmlnKSBhbmQgbm8gaXNzdWVzIG9ic2VydmVkIHdpdGggdGhp
cyBzZXJpZXMuDQpUZXN0ZWQtYnk6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+DQoNClRoYW5rcw0KVmVua2F0ZXNoDQoNCg==
