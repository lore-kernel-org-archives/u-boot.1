Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA1CC369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668CC83447;
	Tue,  8 Apr 2025 16:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=voltserver.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=voltserver.com header.i=@voltserver.com header.b="PHUtA9fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D74682F5A; Tue,  8 Apr 2025 14:54:56 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4B682EAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=voltserver.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thom.nichols@voltserver.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWx9BlVhJ5zaFPhQ44vkq3VMnfUj2u6QHX1CrNnwAKHgD6rqmGKl1BEcKxhOhMyugcGAD6cn5Elf3RlJTV8vVX4R5E7zKvpQVFe6FRks1qQQ+5iiBN5Q3yJkbWOgPvuMDXcnnuzD8Da+Nw5cq+utFhnQA9aisdkvc3OUNNc9xigy/gBlBX9ryZM/7HcmakKnR04csS6t21ogJUiegBSlIiRF5X9vahbZtD/thX8m9kZAbz81zl/CwoeSGsOa5MsZ77YiktL7zaLVaYilM3TG+pspijTlJXF6ezQnWEw/SMGcOQYXGGIL3bFr8B8DVYbw3Jsgc8rowvTwz7dg8A99uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91i8/plo9WkUjKB7Vysb6arLB5FBiZfDMus85X4Nbsk=;
 b=ISRPccmEPkoZwWMOnL1xxpUofpULRv4wWU+KwIJkJYVtpH8Mi/J5s7G3pcgII4LJCnyXPSWSeH1B1tCRgdxBnW9s8xezAnL//ayfoGstCfarhwgNYAxN10HMo7PYNSjXtLsePlMRXMH/Ss1jV6T/FXu5LK3U7ZRbtUMrsRod+dsF4DMdz4DamEI4mB6IL/AtSBjXSPeg+fv4uWMCdXB4HQ/b7eWCK9Vn0FsomLRu7KgA3qtdT+VuXTO6nzDTcO0WbXMSWN7rbl7nZwtmBddp/SR6Cd0wTlUhKoeJECPNbqVlG7QZzVaTNDsZkjJPCG0rLZ+vpZ/ARwL4Wculi91FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voltserver.com; dmarc=pass action=none
 header.from=voltserver.com; dkim=pass header.d=voltserver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voltserver.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91i8/plo9WkUjKB7Vysb6arLB5FBiZfDMus85X4Nbsk=;
 b=PHUtA9fMAxFoGGbegtAw3g7loIiu6dwEQhmhF+66/d9Yxq3LTyVeS+QKdQlHOypANTaBO7NMCdEZr8a41O0x5Uvp4c+uBpInCARg17UuHCGMaVwzyqKgDG+jRzmrdSoWCTVHYojyENVLf1Sfv3JGmJqyZG+xZ7zdzCpQN3ia6S4=
Received: from CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 12:54:50 +0000
Received: from CY8PR11MB7945.namprd11.prod.outlook.com
 ([fe80::c90:7c4e:4a9d:8b00]) by CY8PR11MB7945.namprd11.prod.outlook.com
 ([fe80::c90:7c4e:4a9d:8b00%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 12:54:49 +0000
From: Thom Nichols <thom.nichols@voltserver.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: bootcount support for AM62 RTCSS
Thread-Topic: bootcount support for AM62 RTCSS
Thread-Index: AQHbqIOMYDmrrX/YGEu4sJZqgsfzfg==
Date: Tue, 8 Apr 2025 12:54:49 +0000
Message-ID: <CY8PR11MB79456EA41EF6365020C89B98FDB52@CY8PR11MB7945.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voltserver.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7945:EE_|CY5PR11MB6115:EE_
x-ms-office365-filtering-correlation-id: 637db7a5-60d8-4a02-d523-08dd769c8c60
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?ZPNBesNzLz49NAGMjvVnPON5uYyMGhk1iM3rSuZFmuHeHftnkOaXxnlp?=
 =?Windows-1252?Q?MiKn4IJX1kEaitFGlqMmWb2B25D9PQmSvZZzTZTZ32B9k7QPlk40zfnL?=
 =?Windows-1252?Q?WHqX7Tzno6ex7PNRC5mekbgAwP2nx/Su0cTc1B8H/PvMizvjVUhSj3aE?=
 =?Windows-1252?Q?pbiTTXBsehIIwYLnBYhU+fqOROYBBcfLVE5S7pL6FhVbP0Bra9TVdnbk?=
 =?Windows-1252?Q?SHxPU4VWZQSZNXgVe/g5Fp/yZdkDenrg0lgp6XGAW42PH+72c9bYA4pl?=
 =?Windows-1252?Q?NWH0suyUlUugmYw8OvzsVc/6ROnHP9NvEU6Oh0Kg5VxV/JGDL2o/KF/K?=
 =?Windows-1252?Q?m+10YU4PBF5lbV4kWz1+0TTP9mVMP0inQr1F+F2VhxO86T7lo0yH6qwx?=
 =?Windows-1252?Q?XwkillVA1qJV2EtCF8pt61ngYVm8TpFYRN4SpxyCm0oMjKpfV7V3Eh5+?=
 =?Windows-1252?Q?3AvqOzcdEqYQFaLflE8VPLcr5DB9nl000dkMj0EytI3ceI6YKIb7i0qT?=
 =?Windows-1252?Q?cuDkIV0u/iOSyRiTRg/64agCd4vJp+AXgGM+LBPnZFBH00KbDsXoX8dk?=
 =?Windows-1252?Q?OOrsCzKbDS0wh932fXelxDj6aZIjSUfqRbnU2JypZT1yiY/lyIchYgg1?=
 =?Windows-1252?Q?+qWb1LjepaoolAL595VL6uPp6tvnqONJGq6XPwE75I57JIQcQzMvR6bq?=
 =?Windows-1252?Q?waXX7KAxdWwWNG25YeftnxrPtEUlNMLP+WQhcvNPOXTiAv0ZO4tlE7Vg?=
 =?Windows-1252?Q?nWqKAR7LY1DXffwuKSt2nsEO5uS9Ztg8chMzrgduJKt9Yek/+vlbsbeZ?=
 =?Windows-1252?Q?46XMQi7OnuPv29L0cA0tAsEiLL/utt8FttcPeXqr+Hj+SaZaB4/JPUe/?=
 =?Windows-1252?Q?3+tWbAuzSNN1ZX7W9F/inWDbAdz446ukpyk27MClHy5wZbZDe5PSWOwy?=
 =?Windows-1252?Q?x3f0R8sfMYczhwhNdFKKgkmfgHCcGQmgbbDqnn0urDAkNZ3vQ4vQG/2L?=
 =?Windows-1252?Q?j8NqPQ/av8IHOswwKSwZJNW56HIGjAsd0dghu8jqN0i95FF5prReD0jz?=
 =?Windows-1252?Q?GUE1koLJ6ET1Syw378LVFqBPWUOda2+PFhZRhU2FARPRdZRabo21q6zz?=
 =?Windows-1252?Q?nPpEDWEsMpUBSzvDJm8GybjlmWSwSEZlf3sCXxsZWeZBfNqxnDqtjMOE?=
 =?Windows-1252?Q?LB5eHJzo7BG6zrNgB5QRfXRsvd8B2EpU/dHJIm2y4IenarGgImI622EK?=
 =?Windows-1252?Q?P2GwDfcZmm/O6dl/DjgFhDV1QBVdKhOirYzEon6HZpLLE47u+XJiDdEH?=
 =?Windows-1252?Q?3dqhNRkriZrtIj37JvBGnQMjz3e0Yr+C4tAX6QmucTC06Us73RIXwSR4?=
 =?Windows-1252?Q?tOF8w9ZjkmJvLH75cPoaP/SesMe2/5TwKDTOXxp4GxBZHl4paf6WOl3M?=
 =?Windows-1252?Q?jXgARBP0qAZVL4Jvjz+Ifb8pEbNxp1Fbep3b5YFuR1uWgr1w4y8os0hr?=
 =?Windows-1252?Q?2kzgyjfwUWO0Y4+fLWpA9/1dOyI174jEGIWA085WPiv/6ypc/TapkXPM?=
 =?Windows-1252?Q?ZPxJenBhoUQJ/wub?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7945.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?afmU+s7Y/m47OG+3ZsqNGzZ1uFUknkXW/XDlNhRlWzbz4att6jpdTSqc?=
 =?Windows-1252?Q?CUq4qzdr6XdJY/LyyQuP0s1v+PDrs/qOq12gYYA9YG3dEPW1bve6fVG8?=
 =?Windows-1252?Q?7iNQ3IJwNoHv3oZHkDG7p7ZTq7twfRKjZ77CVWfaIiXwMqAsN3B4R14x?=
 =?Windows-1252?Q?nNtXG8O8swWACbZf70PvDlnu/1smL4zFbVuJJ+lW17VEEWAHwWW/CS/y?=
 =?Windows-1252?Q?N4RckJgY5CQLTIfHwrtvfAIJmWuWGcOcRXICrWbwkN2J+Wi+kcZX/lmw?=
 =?Windows-1252?Q?ZL9y/JXv09baUD+QnakFiZzs9uWYRsSibWkFH9MakIRcSAD/FRp/Xeac?=
 =?Windows-1252?Q?H5BEZi1XhuSwbH989XYuyKlEksph9YL/XrcHZ0Co2psMiGpXGymRBrLr?=
 =?Windows-1252?Q?ihS3o8cfvTo5SasDSjbSTj82nPeXrdWYEBZPom8UE6SrGPK+kJucdZ7V?=
 =?Windows-1252?Q?18nHE4mzFREPKbXHKQuDRKHrygGeMl6CEJfwq3dqqlx33u+w6i8v8/Le?=
 =?Windows-1252?Q?XTyjRx8zqhuPtF0eHD7W/Lk0CoIjCcEyemfUa1uwjvGEFmLS0G8sX7wq?=
 =?Windows-1252?Q?W9sFDnV4Zxbt3QNCu1E4jyaHmW2FJQCYIh4un5yoPiWhLHDqdx7u9Kf1?=
 =?Windows-1252?Q?SLmSLYBWgdKaDWA1ZLYChpsGcfJzfCnjksGOCutMKYUFtYZ8mnbhl1zY?=
 =?Windows-1252?Q?94/70zU2IG1qIhF9erfeQo3SAYrN7H1pOt69fQJAx3vIPSF3KHDYc9K5?=
 =?Windows-1252?Q?uRG0Rvtbs7vdkl9basajfOb+nW62z2ar+niFP1d5RuKFHGT9bBvUatJP?=
 =?Windows-1252?Q?7VGUcneX39nJHFNHfdBS5ShhvytprJ/T0hNcvlDby/BOk5NxC+43qjUk?=
 =?Windows-1252?Q?oNUZzB8Fq6CMyJek0ib6JNrpOTsvCylSx1c0BHUUXztGNllIUeaqHC6/?=
 =?Windows-1252?Q?FeO5LIBVmnOBaXUx0ZVsJ1AAv1mntRbQdCzTXnnMc6dpbCvwmGxUdZ8M?=
 =?Windows-1252?Q?goR7kO++WSQCNp4wKWGrCpLu8hoFKYO/lAsi20V8ttdkSzvJnD+a5iUm?=
 =?Windows-1252?Q?TN0hm2PS5xPO8t6WilWPQmwh/oLI2qiXRdveWC+3P+Kz9AaJFVd/BHlP?=
 =?Windows-1252?Q?9kM+dBKu3mjHcW5RyO5qmaVMquIRMsiPC4E9fCPEdKnyVMNsLwyzoqWP?=
 =?Windows-1252?Q?Hpp2AnjNLVHM2pK4KmCnWa7KVlStK6DxRfmAd+G0caRTq+gGfA8XpeYX?=
 =?Windows-1252?Q?L9KdsBbjfGDd4XfmGAAnsBfv/IKhZ/f/LAEfEa+lZTCexhUnxhLplzxi?=
 =?Windows-1252?Q?jfWznKJHvgV+bcxM37FfunEcgYBsTZMEwXRA6CP4X0G3pQIrJKiqFJn/?=
 =?Windows-1252?Q?ug15ra2p5FOMsYkZNc5HaCyKbz+wqM1xXjQkiHzoHdABaUGF7uIizv91?=
 =?Windows-1252?Q?SgpyE9sqsfw1jTSR71eVBwOnyoDlMnxGcbE2w+uNZJbpW8ySlQy4m0ys?=
 =?Windows-1252?Q?UWRELwjFtDhtDIRmfthTEQHdIFk8iZ7qdGhqOQZ7dI3Yhyc01gepfHGP?=
 =?Windows-1252?Q?edzavzD8h/+e9M5AjNQ1cCd/cAP21NCzNtbxNgbpclw57knuqn3SrjPn?=
 =?Windows-1252?Q?ZIIteWHq2C/WAMbwfL2XEE1+z/IFZU9qQFmLFbXXh0KHMHvHTIj0mem7?=
 =?Windows-1252?Q?tXGu5nxX0aWWg52tVGUcO/cHZP0mzSWVTrRsXP1C5KbVyDwZgn/bSfxw?=
 =?Windows-1252?Q?lklSBOyw7GRDzXXLrAk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: voltserver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7945.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637db7a5-60d8-4a02-d523-08dd769c8c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 12:54:49.8403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d954406-2c01-45a3-9cc8-be64a19fb626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMIUq94AZNVKUFKESIqmmgxRbkJKpOwbzGv+05bmsS45zjAPvON3jjLxS/MXlEBj09MgMalNdbOPobT7DkC4BHHSpOpWZoU8y200fAe1zL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-Mailman-Approved-At: Tue, 08 Apr 2025 16:21:49 +0200
Content-Type: text/plain; charset="Windows-1252"
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

I=92d like to get bootcount support for the AM62 RTCSS.  The RTCSS on the A=
M62 is very similar to the AM33.  In fact, I=92m pretty sure the bootcount_=
davinci driver would work for AM62, with just the register address/ offset =
and KICK_WE constants redefined for the correct AM62 values.  A while back =
I tested the AM62 scratch register from userspace [1] and confirmed it work=
s the same as the AM33.

I=92ve never contributed to u-boot but I believe I could get a working PR t=
hat modifies the davinci_bootcount driver, if this would be acceptable.

Alternately I don=92t know if there=92s any near-term plan for any of the A=
M62 maintainers to port the rtc driver so that bootcount/rtc could be used.=
  I think doing this would be beyond my capabilities.

Thanks in advance.

Thom Nichols


  1.
https://github.com/VoltServer/uboot-bootcount/pull/15/files

This email and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you have received this email in error please notify the system manager. =
This message contains confidential information and is intended only for the=
 individual named. If you are not the named addressee you should not dissem=
inate, distribute or copy this e-mail. Please notify the sender immediately=
 by e-mail if you have received this e-mail by mistake and delete this e-ma=
il from your system. If you are not the intended recipient you are notified=
 that disclosing, copying, distributing or taking any action in reliance on=
 the contents of this information is strictly prohibited.
