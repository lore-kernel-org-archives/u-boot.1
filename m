Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4673DC5B572
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 00:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CE8D60AFB;
	Sat, 15 Aug 2026 00:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhMY0e5ydh5C; Sat, 15 Aug 2026 00:52:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BD8960AAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786755150;
	bh=HataCfQkynJoeXxIyu1jz164+15FffLrGl3p5b2fEM8=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BndQeRwi2QwTU2j3DIhRAPozQW7oPl1rtLtD2V+xhBq+K/HL055zZTal3KEAkyXpA
	 RPrilfj2K7PapSn5LyIHaK8H+kbl7oHa6NNX5EQhEuyw4/9FLHRXioZIGIypeLeB5x
	 sCyfZ2v3R/0YYFj8rhQh6hdvIgvkKfTytqu98OkgrVvTyeKuWzNexjXGNuqEBbI20E
	 4+BFI3N86FwOBR/iL/FB5haCmnQJCDyZ6Jv+DtUWZ+QNBkNWt7duIDGI9GZzrRtPct
	 3iogjnYSrHUhwjNlFsxzt4Qarq+YLL/sBoCn24fxvYbLllvj4Ti/VdFYMCyxfXcjOQ
	 86YEDNMA+G6hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BD8960AAE;
	Sat, 15 Aug 2026 00:52:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C56B3DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21EF9606BF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgfLILADJcVI for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:40:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:d116::2;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=macromorgan@hotmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 376D4606A5
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 376D4606A5
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=S4hP7u4Y
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azolkn190100002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d116::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 376D4606A5
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiR3Lg22o34PfrnohW0iBz293EV3i4FjYU5BWyZyyjCGPhFbh64npZtUP3H/q3x4GOGsfo2ODd7vkjQttycVYRlFqe2q7Y3yaHk3pB0BCcjFAiQiO3zfkMa9TYt1T33zIFwYme/X+YxIyOkCDmyrWQYlVoSA/j9nK/cKtCUuNlTjECJUF4OSM/WhkAmCyBMPHK4el0EnodrtirkkDOJ1/fdyMghRRamDmeiz2poejNai142vx9WgDId4mQebTsFaDR1tjXVjcFZQF+l2aqyyLMDJoVtD2u62H2PsoML7y4/MGx/cUSXvBT7/fOUcQCybNqjqrPuPzeXoog9nrmNmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvgcdXw9mIV5QTvvhHTUaEx+mF8oC/dOH46thvDcsoA=;
 b=y2XHJKOzoGeDizoiEE1ARLO8RLEEpeANkuLFdlt/oYpsIWSOzMHlD/Fr1iqX3BpTRBOVOtRhCoKuKlaTWEZxMnt2kH8Izk3eWr7zKfzPwDdu99Lkj5ZsylOJ0sbSqprp4U2g5EC6bUQj9oDqqKEaKJjvpT8cIpdrGQewJAWdZQZ/X8cU+Rwe/vFbKC6RaHyO9jbqO4cb5dW7SuiA3227vlVXlTAGZRD8F0cnu0eJZXsO4IDJMahZ4CdYuD/msQAYUHANwsU6JyIBnJt65LMYjrfQmFBiIK2vx7fJHsLRMuvdABJYZjEMLtafE3DO/C4ibfiXI/9UQTHeYUgY0BHrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvgcdXw9mIV5QTvvhHTUaEx+mF8oC/dOH46thvDcsoA=;
 b=S4hP7u4YiZu+jonBCxYJp4Que29T3g/t7TgoyYBUWgTlMOabLg+zL2oMKkN1xVc29i8+6F95i+xiWF+p6O8E4dyiMstHd6ZcrhRVoATpuRKmJZ7DmZGjXJFVQjp7nWdwwlb3NQqvwI96SDwE6Qfsz2RA2ydhjw/IyB3A7D1aF/uPg0m9TcZr8NHcneDC/YWzGxhedUs5ggdw7wCV9HKy3Hhww4oEU+L4b+PhCksFk6Bjn8bDibD9+Ys7nYf+B9FUI+MaLvjTIwiuwl/hWeJdSVrBQvE3zaTElB/bNyx6K2Vf0ekZuJ7XUlG8W8X3e+OFzNrARuhH4d7ccPo77l1iiA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA1PR19MB6842.namprd19.prod.outlook.com
 (2603:10b6:806:24d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:39:59 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 21:39:59 +0000
From: Christopher Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "dmanlfc@gmail.com" <dmanlfc@gmail.com>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
Thread-Topic: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
Thread-Index: AQHdKm5c/6xATKsZo0yophOOh77mS7aeFCwy
Date: Fri, 14 Aug 2026 21:39:58 +0000
Message-ID: <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
In-Reply-To: <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB997338:EE_|SA1PR19MB6842:EE_
x-ms-office365-filtering-correlation-id: 3d0624f5-50e2-40a6-40a6-08defa4c96ee
x-microsoft-antispam: BCL:0;
 ARA:14566002|24021099003|24071999003|25031999004|55001999006|15080799012|12121999013|39105399006|37011999003|7071999006|31061999003|15030799006|4140399003|25010399006|20031999006|8062599012|8060799015|19110799012|3412199025|102099032|440099028|40105399003|2607281247196008;
x-microsoft-antispam-message-info: =?us-ascii?Q?bIWhS0i9JwMPyZx7eHp5Gn6SfKUJDcdwA9+DeOrtX/oEvW/NfJH5683pWZTR?=
 =?us-ascii?Q?KnKpSptfCiFioMz89ZoT9+ZC+jQzrEEEKHj2IAAP2+qSjbfjL4GzmRDQ5F/2?=
 =?us-ascii?Q?4Jp/aqHiKt4T0DmI4+OF5qVyN6hPakHYpMoyfc3lauP76BS/4AYAJgtmSolR?=
 =?us-ascii?Q?5iljo2I0/iAnpUn79cJV/ZUuGSFlpd1b0ZUbZsbFggh3ZCJ7ZMXkMAs7dBvV?=
 =?us-ascii?Q?FcZao1sqU+aO5TiSBVFyXJFieM/pD6+IB1UCMAH4IpSMvSUZWTjMu2KEqaRj?=
 =?us-ascii?Q?4zwcKIFKu6PloAblCKqdWI/AoJOKbt/DnSGNaPUIAeg17NgYA8rzLUmevRqB?=
 =?us-ascii?Q?+sh8R3HtBV0thT93H2sA7Cz5Ggklxc/DkUmqGZ+AnGNy3kox8szK8YpAcrJd?=
 =?us-ascii?Q?SHnijSGY6GiDpyq9BUr1WkuSBTrrMTYDlK29F57igj67BYNc16w1YxdX80B9?=
 =?us-ascii?Q?0EJj9vrovuT9UiqJ1Tr67BN/su4hq+PcTlXpx99K2q+YG0a9nXBXYGENG5AG?=
 =?us-ascii?Q?NHJ+LatHY2Vh3qvRMw7TZ8QzbEMMomvCxkFtkO2OMNnvY6gOBjGhVXyx2MTJ?=
 =?us-ascii?Q?mx2zjMx7vME1cBOkphH6NwXdEpGWUshQ2DC3k1imUWtR5Wxtbfx+wm3KBWsT?=
 =?us-ascii?Q?zT4bBnC6RVBBe/RVndLZPwNuDySDzL/k2mvswpmSLyaQITDL58z92X/QYuwn?=
 =?us-ascii?Q?p8J2T0qvQPsuZBNLhNFckaxdbqSBe6LXXEDQWLBiqZLIzFFy39Xz9LoyWNHo?=
 =?us-ascii?Q?ZD7b31fTso8UrW7uiDW4SriUQR50SNa1BMxamzuy9QOejciHaaliOXYbOteb?=
 =?us-ascii?Q?9zWxA2cHSD6Fe+EY91Kq9jRo+Ilhqqp/kbrDEwHsi2uMEwDkVnD/hivxNbUq?=
 =?us-ascii?Q?3H3c134jsUw6CdrHvD8AiMXyU4U1YEdCA4q5hC0xv5AAM9ZX4Cy6T3sBJz8y?=
 =?us-ascii?Q?HPIvDLJJSFDmssEIZeeinFTavb1wEZX3vAW6LmuKE54umLOiPM0p1HcbieQC?=
 =?us-ascii?Q?i7yvP61WWr+perVduvBlPgHQ6W2jq+1W5/hSIRDPeKqS5Y9uQkAvvRQtz/GN?=
 =?us-ascii?Q?z8OLMyFKwdU11pesw3nw89ROxv1UlYlhv/ikkg48ZPB6HDSkWM+UVRQPm/9K?=
 =?us-ascii?Q?DgH43GOZI2WUK7bDk1BIfLEyUkQVijvnlttaEH8EmX4j4paLNRb6Xs3h2APp?=
 =?us-ascii?Q?/7pDsA1Rdb9sT0bH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RJRvDQhkxdbCbXuwkRPkHtnTGATLOXT/lEnwUdY57XrHsEy7vHxRzqvr5ZnN?=
 =?us-ascii?Q?tFcBKyPqrmQW3zbztVVkroB5jdsETz/UC1b0b7om9MJoc7xiYktn5b0tHqkD?=
 =?us-ascii?Q?ML8D1I7yoNDDDPH7CKM+l23MUW4FGSYCJlz0LLkphoU3Dpa9DgeO8C3C7Whb?=
 =?us-ascii?Q?nmrDlSeilGjba8msuvms37SpYo9/951NXS6jCA84aLhqwO0aTUuayEDSut91?=
 =?us-ascii?Q?yYKgTIiLnkfXrquLLYIv1sS3GC8rHj7eiO3y6XjVL15nYGZ6IHNNgn5+9ScB?=
 =?us-ascii?Q?nj6BjZSteSw/oFuejpDKgHUNFR+7QKaSjNl5t0/sP6oGiu0Pwxr43r0tOcXo?=
 =?us-ascii?Q?+h/M5jpaVbZFR9MXEIRkYB6xvRIZJrCq4rWv1jW3bSp3GbyVYQc7WWy8aXTY?=
 =?us-ascii?Q?QZJJQsHDdF4PJ1RDv08n0cxwsYrVitnG43xGYBS6CCmzUA/TuO8hXbvd5qlW?=
 =?us-ascii?Q?CFrmKWtFea+meAW+pL3uGQkP5JDUdb2DWOJwVGRePlfwUwwwaD0RqzsbZ9xj?=
 =?us-ascii?Q?jkhPl+xFSQ0M4V+0iNiAoF1UFunXkJDWqHyYB0Y+5BZHmVgvfCRi3y/UpzSD?=
 =?us-ascii?Q?xMvsEqMZfnJfCTLv7iffNrIUWcWIUEhe95EP9yLRgi20VquDWdXIysRfxWo1?=
 =?us-ascii?Q?uChGB1oWXWHsNNDbJFXbWldAQXNN4Xw8JPge1ddmMmZQhB+M7+MfYXigOvW9?=
 =?us-ascii?Q?eRniPLgIlbWgLr67dFtSK6MD1DrU//Gsm/wW0S79ZkBKpWn8zHeS6qw0gU1O?=
 =?us-ascii?Q?m5ackd8UovogETVAXLhV8xMSmWX+XEImF19cvrje1uNPmFE+OGyrUn1eghZc?=
 =?us-ascii?Q?4dWb4LOH/b9BYrFqWDAM7142kespba+EgzCSloQc37TDRcz/FX/nvUbR9FO9?=
 =?us-ascii?Q?nXCgTkmQzpV3wyuaXFqbL/E675TaWCFZsNB5hOT1OTxsSOe2T5C76IyGa+04?=
 =?us-ascii?Q?XYdm9pR5OJ1Gln29OdKBgHvEY4/2fQOjZ5O/+aNNhP24msVLHklKxaXe+rOg?=
 =?us-ascii?Q?kfu9fndvStbG79lkfTLrhIJEw0OykmFcPqDyWJBpug7zmalpYVE8RRKhUeEq?=
 =?us-ascii?Q?FGEZIYyS9PLTSeOT4SDxMj8X0ZXDl8Y48HadoE6jrhEDQRB3wlZTnhkfoSDJ?=
 =?us-ascii?Q?1h2MUFfCjkXI5I2xWrCX4Q8L2tT1hMM2vArlQ0V1wtz7snfAv7nYXeALmYTn?=
 =?us-ascii?Q?IH4Ht4+dnTecf3d/nYcQDdvsfpnnKjRXDGJzdMBMvfdB34EHl60vB8qd+91J?=
 =?us-ascii?Q?oxP5ndg650RC8sCYd2Cr5vUDYagIeQFdwkyyvJw+p+mIpWCtXR+My/0YC/G8?=
 =?us-ascii?Q?WYfATwpWCGc8OTCE9exqJbWesNkN/jwa9iUSDAvDR0uUcUJ+/OeJD1oamfdA?=
 =?us-ascii?Q?opueZQwaFcS/RiN4ZC7nq3qisA9Hr2+C2xFWnTkL4Mk/Lvvc9GBPHPA/YgcP?=
 =?us-ascii?Q?500IH5nU4YJ7JB/1qnfZNqi/OxIlCMev?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0624f5-50e2-40a6-40a6-08defa4c96ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 21:39:58.9816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6842
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:52:29 +0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

I'm having trouble with my usual email client, so I'm sorry if this message=
 is formatted weird.

I have tested the device most recently with 2026.04 with the default defcon=
fig options. I am using mainline Arm Trusted Firmware though, not the Rockc=
hip versions. Using Rockchip's A-TF should work, but again it's not somethi=
ng I've tested. I can note that if you're using mainline A-TF along with ma=
inline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3DN, otherw=
ise the device will fail to boot because it won't protect the Optee regions=
. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is optional unless yo=
u use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLATFORM_PARAM=
=3DY).

I'm going to test the device next week and see if I encounter any issues wi=
th it. I'll report back if I find out anything weird.

Thank you,
Chris
________________________________
From: Quentin Schulz <quentin.schulz@cherry.de>
Sent: Wednesday, August 12, 2026 10:22 AM
To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>; dman=
lfc@gmail.com <dmanlfc@gmail.com>
Cc: Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK358=
8S)

+Cc Chris who maintains this board and may be able to help.

I somehow didn't receive this mail in my inbox, here's my attempt at
quoting text from a mail I didn't receive (and it's also not available
on lore.kernel.org...).

 > Hello,
 >
 > I am experiencing a total boot failure on the GameForce Ace handheld
 > console (Rockchip RK3588S) when trying to run mainline U-Boot
 > v2026.07.
 > The device fails to initialize or display any output during the
 > initial handshake.
 > Unfortunately, due to the tightly integrated form factor of this
 > handheld device, it is exceptionally difficult to break open the
 > casing and wire up a UART serial console to capture early boot logs.
 > The target operating system (Batocera Linux) environment is running
 > the mainline Linux 7.1.5 kernel.
 > Given the complete lack of visible console output, I wanted to check:
 >
 > 1. Has the GameForce Ace board target been actively tested with the
 > v2026.07 release?
 > 2. Are there any specific or updated build instructions, BL31/TPL/SPL
 > combinations, or proprietary Rockchip firmware binary requirements
 > (rkbin) needed for this release that may differ from previous
 > versions?
 >
 > For reference, the build configuration used was: gameforce-ace->
rk3588s_defconfig
 > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bin /
 > rk3588_bl31_v1.54.elf
 > Compiler: GCC 14.3
 > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
 >
 > Any guidance on known regressions regarding this target, or
 > recommendations on how to isolate the stage where it hangs without a
 > hardware UART, would be greatly appreciated.
 >

If you have a known working version of U-Boot, maybe start a bisect with
that commit as good and 2026.07 as bad to isolate a commit that broke
the board.

Cheers,
Quentin
