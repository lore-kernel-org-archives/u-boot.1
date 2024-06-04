Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A0C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E87884A7;
	Tue,  4 Jun 2024 16:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="jVlWTW9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD124883F5; Tue,  4 Jun 2024 16:27:59 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139CD884DD
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlFkmXBFBEjtlCWFfSsY0qMqdCoqgppdD4a3x7LXHLOTZaqT4p0kPk53tkDuu5twe7/Dvs6y77DIxuOzRMrLXPehaThEO1ER9uu0ca+4lnKACQBAsO48euqUZopC6rh8yC5v+1wobNMqfEkqolDXTunIOvc+7tmOfLoOOk1UgazFhV+bd6GS2N53hdYwYWcdQJtSmnSL/hY02wrDfS9kTrQptswcRGTWP6oJnCm4Nxkdp0BeDu/BXqwYNVrJz+o0604neLeb/eqy5f40PbBKE7yjJ3NmIbM6qK8bTIEbNuIHQUoMONorIjrE3Kx0saOg+Lj8VKtJ4VPKeWbI7H8bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asc2GV8/JO329NTTlqPD+VwENZNepsnEf03tfbJt/Pg=;
 b=iQ1sZhpom5pQ+aVgunNrViAECMZkZQq5lOXkgc9Pk6qQoKrcMdN5YwpPMCDPQ/lUjDhnTlS29bx20DDmrVIYT8OlUOmuA/MbZYvYNt1m3cbe90evqhD2EyKmDQaoamSgq12txYpd1SXrN9l5JK9EH+RTDuwhE9l6c8OieiacauE5/Mk/hxBobpP/7n7mZGA2OJpRwROVtOWKXzv/EaaqsnIgkt7PW7mZEjse4Sjl3Zwec3pGfX0Hr7O/pX7hJBFfcnJkQc/OisQSZg0sdXH5JUdryQrlUJ7/dKEQozxY/32jlVGlBsBjC6WGMuNh7KYTCSCmhlGmXJOg6oJIMXzFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asc2GV8/JO329NTTlqPD+VwENZNepsnEf03tfbJt/Pg=;
 b=jVlWTW9FquGrc5lo3A/NRhgDX1OuGTXwHP9Gz5T7b73XSnbjtQPbhFzIUPrEeWKy64Zy8iKf9mNrbFEkgngG1YN02SGuI1IlT+Aku9mHV7MKZxaholHrvxA9qfystmatEdHpYCUP8eWNgl+PxxeU8x9DC4ezSm+WGh3dkUtPIOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:54 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:54 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v3 7/7] drivers: misc: Add driver to access ZynqMP efuses
Date: Tue,  4 Jun 2024 16:27:41 +0200
Message-Id: <20240604142741.425307-8-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: d602ac2e-b03b-4754-dc75-08dc84a2854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azRBdG1zOW9IOEJQRC9ZckNXaFNxeVhQR2V6Sjg2Y1RsemxMSkZZM3JNZkw5?=
 =?utf-8?B?N1Z0aFV3Z3ArcWVEM21hNCtOTGx3bFRoOWdOTjRlZFNjVHgrSGxEZUg3N0JH?=
 =?utf-8?B?MFdxV1VrbXorVkQ4TzVTR2Y4VkJIM2twYVJWaVR0ZktQdnFHYU1SKzRzTzcx?=
 =?utf-8?B?aFdQWERoZUp3aUNVVDVGRlNwcjA4dzhLcDJzSVVWb2VvNzk4K0Fkb3N4c3NN?=
 =?utf-8?B?RUlqcmJCS1RiWWM3VXk4RWVPTmc1Z1Y4OUpNVmVSc1B2WExjYnhIZldXak1Q?=
 =?utf-8?B?dlZLb2FNOUJqcEFxb2NzRWhyd2FidkJDOTc5bWhlOW5NN2JpSWg2QldmcVpp?=
 =?utf-8?B?c1FCWkltN0U2Qmt4YlNHbVJwN04zZ21iTmN4blRKVWZNdHZjT0VzQ3RaOWQ5?=
 =?utf-8?B?OENTMzZ5ZVM5SmRJVEVxODZJcDQrbkVUMXBGUzhONkJid3dYQ1Y0cXo3V0lx?=
 =?utf-8?B?RzZFMVEyMzhYSUNHTVo3K0paakh6RExzRHFCcklWbkNZRG9zMTdObjVjS3Bz?=
 =?utf-8?B?bnE1clZqOXZvTThMejcyR1FjYjN6NTE2MTg4cllRdWJEVk9xWHhZdmtpa3Mr?=
 =?utf-8?B?ZFRTVXpGV1VnVHJQUml4Vk9NOGdTaW92aVJLQjliWGRoMWxSeldXa2Y3NjhY?=
 =?utf-8?B?R3k1ZTBOSFg5ZytWZ2wwcFpJelBzVnd0YTJMaW5sN2dQK1MwQ3hLUkdTei9P?=
 =?utf-8?B?MVN3WUJvd1hyV1RpVWk0N0FCZUgyQmZxVDJnWTJBK3ZUQTVpeTBVd2hZMjhZ?=
 =?utf-8?B?cit6MDNic3U5cGx0eWZKVktCOG8wTHE2Vk1neHoxRm55YWZXM2hrNzJhSm82?=
 =?utf-8?B?RkU1emFCZldrYm9abUovNTlybUhOYTRZZDNxNlJQVy9xMzFGM2t0eC95MUcr?=
 =?utf-8?B?MTBDL2JmbndtV0V4NFVDWktMT0EvTXFjUG85K3lwcnRtQUVFVFN0VzczeTFv?=
 =?utf-8?B?ZnlYS2JnLzR5ZW5MY292NkxpSXdBNVpYUC95bWNVVVVLRHFzRlhMclB3ODdw?=
 =?utf-8?B?eDFRelhmT3N5bFJNTlYwR0QzMHJnYytiWEsvUGM0NTgxaHJxUzRVRXd3R3cr?=
 =?utf-8?B?eGd2MWEvYnRCTjVPaUNGWnR3Y1FjSllPenBlL2l1Mk1za0pwcXg5TVU2bUd2?=
 =?utf-8?B?S2U5Nm1melJ5N2xWOGNtdVhGZmNQMUN4d1FrYW9DZWFYYzNVNCtYdUMyWm9r?=
 =?utf-8?B?WnB6bCtWSDBnc0xuYzhsR3U2UkhReFh1TjVWVlgrTFMwQStJbitEZ1N3L0hU?=
 =?utf-8?B?b2txZmwrQlV6M0NrbVEzNXVJMk5nbFVTTGdVSTBxVmlqcENxdk9kb1dmcmJs?=
 =?utf-8?B?ajR3bS9hTHpHaGoweTVnYk84aXBrRkNvdzUyanBWS0EzNnovL2lDRnUwOEF4?=
 =?utf-8?B?ZDdabHRKNXNwSE9IU0kwQ2JoNkI3U2VpcWpYUWxpZ3d1OTBqMis3RDFzSHJk?=
 =?utf-8?B?eEs1WWw3bVQraFBmWTlZUzVWTE1NVjFicjlZZ2xNbE45NFVvMDVZeXZTMUhw?=
 =?utf-8?B?V1FSTU1ja3dGTHpGNWRLSGV2TjdqSVJ4QmdWWDQvV0Y5enU4TitkVHByYjQ1?=
 =?utf-8?B?Q1Z6Yjl5ZDhoQlJEUk9DZXMwbmhXamJGOHhnVnhXcHprZjRMS0F1WU9sUkd4?=
 =?utf-8?B?eko5dHhmaGxRVm5tQWlPQzBzQ1hXM2lXM0N4RGdPaTVxVEpyRFFDVFoxQ2cz?=
 =?utf-8?B?eitZWGRHd0JxSmNacjZEcmV5SEJCVUJlaktTUjVoTEVOQ2FxWjJkbHZUaHZ2?=
 =?utf-8?B?c1FqVTJKakI5OVdvcmVvOFB2U2Vma1ZidFNJeUc5ZnJQeEttS1VuSm02RVM3?=
 =?utf-8?Q?66KGQE6cJbeENiPN0rpOPNcQrw4/w92I6FWVw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnYxQXQ0U3JmTjgyQnRweXM3a29RdTNscmphbTRDWTdjV0lCaEwzWlhDc3pq?=
 =?utf-8?B?Z1d1dHl0VEtwZThhMWVaY1VvMndIekg5SGRpOFBFbmFVTm5IUzk1S1hmYnpC?=
 =?utf-8?B?Qy9wenZ5UDlMdUczMm9lV2RubTJJRXFUYTZ2a3hTdEx1am9BWE5GZ3Q0Qm9C?=
 =?utf-8?B?Rmh3eW1WV2lNdkwvRmxPZ3p3VUl4MjBCakgwWDlueGFRMGthSWhzRTkrc1lv?=
 =?utf-8?B?UnhJdERpNy9hMnV3a3ErMjljVEJSQm40MTdsQXhVd1VDMTRJVWFZWjh3SnlC?=
 =?utf-8?B?Q1NvTWJrWHFaeDhNbXVEWnlLUG84TzFPMmJRaW53V0NlazRnSW41NTZpRkVC?=
 =?utf-8?B?Zy9JYnl4Y3JtaWZWcEVJZHpGZTRsQWFKMnFOVnlFNmdQMlFkNEtJVytuVFBk?=
 =?utf-8?B?Uk1iWHN4TTBMam5OV2xNaW9wL3VOUXl6bGNBOVBmWVdRY1NIZkt1L2h4bGFI?=
 =?utf-8?B?QldHay90eHBKczlHZUxvb1ZZR0VCeWpiR2sxazMybVRYZGZkNitWbEV5dlVN?=
 =?utf-8?B?YWRXVW1jREljVHpMeVBnVVNzd2x3WmJHVlZjQjRhU0I2K2xVcnNkVzRiMWly?=
 =?utf-8?B?aE1hdGVWZ2dXU0xEMDF4S2JibWFJcFljL1FDRmtOcVp1QVorVzl3eEV1VTg1?=
 =?utf-8?B?RWhmOWdKeG5HSFZDUGQ4ZkpoWTFvWEdNanJHdzVhbFFhRDduZ2c2YzNYTGU0?=
 =?utf-8?B?Um1QRlVqS3JvSXBaNVJnd1d4LzFBbkltTUsyWEhBYmUyRlA4K0hWR3k0OGF4?=
 =?utf-8?B?NUp5ekhZYmxhRUxUaFUvQXhkNzYycmZTRCt0dVpTbkt6cHNKQzB5QndXTFpy?=
 =?utf-8?B?Q1ZxdnVwalZzcXZXcGFxMXFyRmR5aFQ3d1BnQjhEbDd0Z2EyVk1Cc01uSHJX?=
 =?utf-8?B?OTRvcEo0Y3hibGpVOHMzT2M3VTRLOHRsaUlBZkdMcllPMUd5RCtwaEVESFRO?=
 =?utf-8?B?T2o0elBtaVVGMjd2VXJIejNlOGV3bG51d2VodTdtYS9tbHdOckdUM0kwdS9K?=
 =?utf-8?B?VWFLbnZPRW9sb1ExblJyNTBmTURibWxrU0l2SkJFOVQzNk9NR3FkaXpDWHc4?=
 =?utf-8?B?bzhoc0c4OFN0YXRBU3JWaEZaQWxJd2dSY3VjSlZISC9oNW5VRVNFYWdZemdV?=
 =?utf-8?B?UW5CTHl3TkRaRXBwZmE5QjFSYzVQWTZsb3VYcGFZUXZ2TE9QQ3VhR2YyS2dS?=
 =?utf-8?B?aS9uNi9IRDZ0RUlYdlJlS1gvcDk3eWhsUHRjai9mWXY0SkNVQUwvS3NMMmlx?=
 =?utf-8?B?Skx2emZreDBqOXpXeURuTFVFN2J2NWJWRUJlWjJMT1Z5a0ZMTWc3a3lOd1Rr?=
 =?utf-8?B?TDY0TUpTcUVhS29JSHFLQThsdlhjUWF6YTJYR01DZytKOXVKSkVmUTU1dkRv?=
 =?utf-8?B?UnIrQnY5NTlkOVZEckt6YlhwclZFV3J0SkhTbERpNmN6blY2TlpGU2lyRjRz?=
 =?utf-8?B?Z1J1OWpKM1hwdExyWWdZZy9mSGtVSEZ6d080TDNmS2N3M0M5Y2M5Rm1sbFVT?=
 =?utf-8?B?Qzd2dWhUeHJlZDdOVHdWY3BsUDRWY3NzSWFiOGg5UDdMaHFySDJNVVU4RmRz?=
 =?utf-8?B?WlBpekd2VklTc3ZFYlFSWENzNXJjd2J1Y3ZteTh3Rk5pS0x0MEp6cUlkMHZk?=
 =?utf-8?B?N0VLb2NteWNIZnRZNnljaE8xazA2Zi9TQm82a3g5d0wvR2ppaU9xOWpicSt3?=
 =?utf-8?B?dWhFWkEvckdHb2RSb1ZBQkFPb1BXQzlJYmpJenF3UTY0dFBRTElGdjNhTjBS?=
 =?utf-8?B?ZFlIdkNVMGZVWVFBc3Awcm9SZVZuNVdya2RYOU5hb2hvRnhZQ1ZINm9hNENu?=
 =?utf-8?B?azBLemQ3a2hGa0tKQS80TTI1ZkRxQWVodTBLNUpJQVhrRFNSZnl3bHZuZHJq?=
 =?utf-8?B?b3FFSUJMSCtQT3BidHVYU0dGMWdUZXA4NlhlaE81L3hNNlpkMEduNFFqdW1N?=
 =?utf-8?B?REgzbUc3aXgvMVZiN1JZN0tLOXgvUDdLTXQwaW02YWJ2Y3hQVUNtbE1EU0dL?=
 =?utf-8?B?Z1FvZlhlTUtTU3ErMUVpbzEvYzFnRWkrOVdhUzJ1cHBiTllyNXN5VjVmWnZn?=
 =?utf-8?B?bmpYdUZlRzlWQVpBNXhybjFyekxacVJCWWtZbVN5bDZtVlNKK3VvdkdITS9I?=
 =?utf-8?B?dDVLNGxGTzhaaW9CMTBmakVabG9GS2ZuWlNscXZNRzVaandHSnFvdE40NWdO?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d602ac2e-b03b-4754-dc75-08dc84a2854d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:53.6878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crz1+lJ94bF2sfE8uVFV5RMEpKXkouHiH0f82R9sNuoNz3DyGJ50nVWXGKaaf6v/OJV3HXj8no3O5VZAD40UUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add driver to access ZynqMP efuses. This is a u-boot port of [1].

Note: Accessing eFuses requires eFuse access to be enabled in the
underlying PMU firmware.

[1] https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
- Align ZynqMP eFuse driver with Linux kernel
- Adapt versal, versal-net and zynqmp to use common chip-id function
- Enable CMD_FUSE and ZYNQMP_EFUSE for zynqmp_virt and zynqmp_kria defconfig
- Use 'dev_err' instead 'log_msg_ret' if possible

Changes in v2:
- Drop vendor specific fuse cmd, use existing fuse cmd
- Minor code refactoring (reverse x-mas tree)

 drivers/misc/Kconfig        |   8 +
 drivers/misc/Makefile       |   1 +
 drivers/misc/zynqmp_efuse.c | 360 ++++++++++++++++++++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 drivers/misc/zynqmp_efuse.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..c07f50c9a76 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -298,6 +298,14 @@ config FSL_SEC_MON
 	  Security Monitor can be transitioned on any security failures,
 	  like software violations or hardware security violations.
 
+config ZYNQMP_EFUSE
+	bool "Enable ZynqMP eFUSE Driver"
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU firmware
+	  interface. ZnyqMP has 256 eFUSEs where some of them are security related
+	  and cannot be read back (i.e. AES key).
+
 choice
 	prompt "Security monitor interaction endianess"
 	depends on FSL_SEC_MON
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..68ba5648eab 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
 obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
+obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
new file mode 100644
index 00000000000..d12de7494d2
--- /dev/null
+++ b/drivers/misc/zynqmp_efuse.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2014 - 2015 Xilinx, Inc.
+ * Michal Simek <michal.simek@amd.com>
+ *
+ * (C) Copyright 2024 Weidmueller Interface GmbH
+ * Lukas Funke <lukas.funke@weidmueller.com>
+ */
+
+#include <compiler.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <zynqmp_firmware.h>
+#include <asm/dma-mapping.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <misc.h>
+
+#define SILICON_REVISION_MASK 0xF
+#define P_USER_0_64_UPPER_MASK	GENMASK(31, 16)
+#define P_USER_127_LOWER_4_BIT_MASK GENMASK(3, 0)
+#define WORD_INBYTES		4
+#define SOC_VER_SIZE		0x4
+#define EFUSE_MEMORY_SIZE	0x177
+#define UNUSED_SPACE		0x8
+#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
+				 EFUSE_MEMORY_SIZE)
+#define SOC_VERSION_OFFSET	0x0
+#define EFUSE_START_OFFSET	0xC
+#define EFUSE_END_OFFSET	0xFC
+#define EFUSE_PUF_START_OFFSET	0x100
+#define EFUSE_PUF_MID_OFFSET	0x140
+#define EFUSE_PUF_END_OFFSET	0x17F
+#define EFUSE_NOT_ENABLED	29
+
+/*
+ * efuse access type
+ */
+enum efuse_access {
+	EFUSE_READ = 0,
+	EFUSE_WRITE
+};
+
+/**
+ * struct xilinx_efuse - the basic structure
+ * @src:	address of the buffer to store the data to be write/read
+ * @size:	read/write word count
+ * @offset:	read/write offset
+ * @flag:	0 - represents efuse read and 1- represents efuse write
+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
+ *		1 - represents puf user fuse row number.
+ *
+ * this structure stores all the required details to
+ * read/write efuse memory.
+ */
+struct xilinx_efuse {
+	u64 src;
+	u32 size;
+	u32 offset;
+	enum efuse_access flag;
+	u32 pufuserfuse;
+};
+
+/**
+ * struct efuse_map_entry - offset and length of zynqmp fuses
+ * @offset:	offset of efuse to be read/write
+ * @length:	length of efuse
+ */
+struct efuse_map_entry {
+	u32 offset;
+	u32 length;
+};
+
+struct efuse_map_entry zynqmp_efuse_table[] = {
+	{0x000, 0x04}, /* soc revision */
+	{0x00c, 0x0c}, /* SoC DNA */
+	{0x020, 0x04}, /* efuse-usr0 */
+	{0x024, 0x04}, /* efuse-usr1 */
+	{0x028, 0x04}, /* efuse-usr2 */
+	{0x02c, 0x04}, /* efuse-usr3 */
+	{0x030, 0x04}, /* efuse-usr4 */
+	{0x034, 0x04}, /* efuse-usr5 */
+	{0x038, 0x04}, /* efuse-usr6 */
+	{0x03c, 0x04}, /* efuse-usr7 */
+	{0x040, 0x04}, /* efuse-miscusr */
+	{0x050, 0x04}, /* efuse-chash */
+	{0x054, 0x04}, /* efuse-pufmisc */
+	{0x058, 0x04}, /* efuse-sec */
+	{0x05c, 0x04}, /* efuse-spkid */
+	{0x060, 0x30}, /* efuse-aeskey */
+	{0x0a0, 0x30}, /* ppk0-hash */
+	{0x0d0, 0x30}, /* ppk1-hash */
+	{0x100, 0x7f}, /* pufuser */
+};
+
+static int zynqmp_efuse_get_length(u32 offset, u32 *base_offset, u32 *len)
+{
+	struct efuse_map_entry *fuse;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(zynqmp_efuse_table); ++i) {
+		fuse = &zynqmp_efuse_table[i];
+		if (offset >= fuse->offset &&
+		    offset < fuse->offset + fuse->length) {
+			*base_offset = fuse->offset;
+			*len = fuse->length;
+			return 0;
+			}
+	}
+
+	return -ENOENT;
+}
+
+static int zynqmp_efuse_access(void *context, unsigned int offset,
+			       void *val, size_t bytes, enum efuse_access flag,
+			       unsigned int pufflag)
+{
+	struct udevice *dev = context;
+	struct xilinx_efuse *efuse;
+	ulong dma_addr;
+	ulong dma_buf;
+	size_t words = bytes / WORD_INBYTES;
+	int ret;
+	int value;
+	char *data;
+
+	if (bytes % WORD_INBYTES != 0) {
+		dev_err(dev, "Bytes requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 0 && offset % WORD_INBYTES) {
+		dev_err(dev, "Offset requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 1 && flag == EFUSE_WRITE) {
+		memcpy(&value, val, bytes);
+		if ((offset == EFUSE_PUF_START_OFFSET ||
+		     offset == EFUSE_PUF_MID_OFFSET) &&
+		    value & P_USER_0_64_UPPER_MASK) {
+			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (offset == EFUSE_PUF_END_OFFSET &&
+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
+			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
+	if (!efuse)
+		return -ENOMEM;
+
+	data = dma_alloc_coherent(bytes, &dma_buf);
+	if (!data) {
+		ret = -ENOMEM;
+		goto efuse_data_fail;
+	}
+
+	if (flag == EFUSE_WRITE) {
+		memcpy(data, val, bytes);
+		efuse->flag = EFUSE_WRITE;
+	} else {
+		efuse->flag = EFUSE_READ;
+	}
+
+	efuse->src = dma_buf;
+	efuse->size = words;
+	efuse->offset = offset;
+	efuse->pufuserfuse = pufflag;
+
+	flush_dcache_range((ulong)efuse, (ulong)efuse +
+				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
+	flush_dcache_range((ulong)data, (ulong)data +
+				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
+
+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
+	if (ret != 0) {
+		if (ret == EFUSE_NOT_ENABLED) {
+			dev_err(dev, "efuse access is not enabled\n");
+			ret = -EOPNOTSUPP;
+		} else {
+			dev_err(dev, "Error in efuse read %x\n", ret);
+			ret = -EPERM;
+		}
+		goto efuse_access_err;
+	}
+
+	if (flag == EFUSE_READ)
+		memcpy(val, data, bytes);
+efuse_access_err:
+	dma_free_coherent(data);
+efuse_data_fail:
+	dma_free_coherent(efuse);
+
+	return ret;
+}
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct udevice *dev = context;
+	int ret;
+	int pufflag = 0;
+	int idcode;
+	int version;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	switch (offset) {
+	/* Soc version offset is zero */
+	case SOC_VERSION_OFFSET:
+		if (bytes != SOC_VER_SIZE)
+			return -EOPNOTSUPP;
+
+		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
+		*(int *)val = version & SILICON_REVISION_MASK;
+		break;
+	/* Efuse offset starts from 0xc */
+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
+		ret = zynqmp_efuse_access(context, offset, val,
+					  bytes, EFUSE_READ, pufflag);
+		break;
+	default:
+		*(u32 *)val = 0xDEADBEEF;
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int zynqmp_nvmem_write(void *context,
+			      unsigned int offset, void *val, size_t bytes)
+{
+	int pufflag = 0;
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	return zynqmp_efuse_access(context, offset,
+				   val, bytes, EFUSE_WRITE, pufflag);
+}
+
+int fuse_read(u32 bank, u32 word, u32 *val)
+{
+	u32 base_offset, offset, len;
+	struct udevice *dev;
+	u8 buf[128]; /* maximal size of efuse is 0x7f (pufuse) */
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(zynqmp_efuse), &dev);
+	if (ret)
+		return log_msg_ret("uclass_drv", ret);
+
+	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
+	if (ret) {
+		dev_err(dev, "Invalid eFuse word offset\n");
+		return ret;
+	}
+
+	if (len > sizeof(buf))
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(buf));
+
+	ret = misc_read(dev, base_offset, (void *)buf, len);
+	if (ret) {
+		dev_err(dev, "Cannot read eFuse @%u: %d", word, ret);
+		return ret;
+	}
+
+	offset = word - base_offset;
+	*val = ((u32 *)buf)[offset];
+
+	return 0;
+}
+
+int fuse_prog(u32 bank, u32 word, u32 val)
+{
+	u32 base_offset, len;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(zynqmp_efuse), &dev);
+	if (ret)
+		return log_msg_ret("uclass_drv", ret);
+
+	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
+	if (ret) {
+		dev_err(dev, "Invalid eFuse word offset\n");
+		return ret;
+	}
+
+	if (word != base_offset || len != sizeof(val))
+		return -EINVAL;
+
+	ret = misc_write(dev, word, (void *)&val, sizeof(val));
+	if (ret) {
+		dev_err(dev, "Cannot write eFuse @%u: %d", word, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int fuse_sense(u32 bank, u32 word, u32 *val)
+{
+	/* sense is not supported */
+	return -ENOSYS;
+}
+
+int fuse_override(u32 bank, u32 word, u32 val)
+{
+	/* overriding is not supported */
+	return -ENOSYS;
+}
+
+static int zynqmp_nvmem_read_compat(struct udevice *dev, int offset,
+				    void *val, int bytes)
+{
+	return zynqmp_nvmem_read((void *)dev, offset, val, bytes);
+}
+
+static int zynqmp_nvmem_write_compat(struct udevice *dev, int offset,
+				     const void *val, int bytes)
+{
+	return zynqmp_nvmem_write((void *)dev, offset, (void *)val, bytes);
+}
+
+static const struct udevice_id zynqmp_efuse_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+
+static const struct misc_ops zynqmp_efuse_ops = {
+	.read = zynqmp_nvmem_read_compat,
+	.write = zynqmp_nvmem_write_compat,
+};
+
+U_BOOT_DRIVER(zynqmp_efuse) = {
+	.name = "zynqmp_efuse",
+	.id = UCLASS_MISC,
+	.of_match = zynqmp_efuse_match,
+	.ops = &zynqmp_efuse_ops,
+};
-- 
2.30.2

