Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DCC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 07:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C22876BD;
	Tue, 12 Dec 2023 08:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNCiYj6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF74F87792; Tue, 12 Dec 2023 08:25:12 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782E3875EA
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONFHQ5lWX4pr1npDp2cwCGf+AIC8pIFu0//HupioYL5HeWHkSA9+pUCH8tJdwN10dPRoOMJnJLy++psWhDO/Q4NV/zCfNs+nSZYH9n3ct12uYG2HNU4Drrpoc/H/kEPbAe7VCb+eZDxdbGLoxlGEYsrOOwwIo790Yy+TnTqjzQkl6h8GIN8oEERv/YRmUqd4+PyHI2p0lH3WrZwRYaAAq56vUX/HeBAx3xjA6Cvg2ZlzQHLfEMFxkwFdALmTXzTYkhpCfJQoY6LZWlDS6xRtlaasei001sxBdIdIQh20pnsi5SCXZE8poW3yDMLaKYSh6ZIzcOHhIgaAX+L8SYjQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5klPFLpr9kKAmsVva3JnuelcNzWPuVgN8JbzjH1kO7I=;
 b=chkZrXgEa+i+ENe5UgoFU5xLL2aslLVKpLaujCN3hNweR1iyqAc+9fu0gIZiwVlgmziLZXXZNxb1gWyfpvUy4dG5c5i57LzM+8bInXf48Zq/3g0cyoRvYikL7I4fG1sDflKuB4dc1wXrRy88WWIBq1M0jma7oVy8JCfHZA+3djOfCfgL7Nc420QqXqWhKkWtmyRG11A5FNRLzpGwKmG3M6LBuLFARLbBkEFoM3AwUmKWIk4n97vPE+OCbEi74nZ4reZmR9w+eYQXmXTohygLQJ9AhLheCJJZBkwYn6mBz+scjw77W2EcHaybHNXCzspEDC4MXIKP8jjmRYTZL596qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5klPFLpr9kKAmsVva3JnuelcNzWPuVgN8JbzjH1kO7I=;
 b=QNCiYj6W+EpfFRXp79vteO0wToob+EvIGUsLUdqSM5RA3CJE8WvBtwyKzMmm2xnH2HKjpBsH5Tsn+J0WcOej1KuOky1BTuYPqrSgXPVYT2zmlpqIpGHazwB0fmQkK0OasQVFIXSVe3hCZzx0Z63qy0/3QeQ1nWIBuUDpf6qKu8E=
Received: from CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 07:25:06 +0000
Received: from CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe]) by CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 07:25:06 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "luca.ceresoli@bootlin.com"
 <luca.ceresoli@bootlin.com>
Subject: RE: [PATCH v1 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Thread-Topic: [PATCH v1 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Thread-Index: AQHaKo/Usqp02QQ5e0uWBLsCEiECx7ClQw1A
Date: Tue, 12 Dec 2023 07:25:06 +0000
Message-ID: <CH2PR12MB50041F981ACD467B816CDB7EF08EA@CH2PR12MB5004.namprd12.prod.outlook.com>
References: <20231209110647.890409-1-neal.frager@amd.com>
In-Reply-To: <20231209110647.890409-1-neal.frager@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_|PH7PR12MB5688:EE_
x-ms-office365-filtering-correlation-id: 4d90dfe5-7539-4a8c-17c5-08dbfae37700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJKVyfEjt5awsK3jaM1hdlYc4anSo4jFUJpbfJOeBbQnqC8BQd3aIswnsKPJAXQH/lwkEIqafok0KT01mzv7NRPlV1qSftbUsyp0pe8lZFBDrQdfRWm5ygFiP54aEI2sn+6m51C8oJX+EQj0lPi/HBYdAojXI3esnsOvNtSTvbNVldq6RjCnOwVSS1EA/HrFOhgztz91AvHrecueyjvlbCygQDlolJyvnTOSk/PHxWi7F7BJppPCHXzRquHB+QdpEGZPUloZJAI2XyyH8rLjwiQWnI12YyDUyZIoV/weQhLUP0V76UbaoK+mkn5B3v/O671kBdfvt/9oLApqan/VGwPEH9UIu7IIjpne6G/WuS9lpvBKeUvk/vxRd3+8hx9+TtKEypAIZ1S//rBtdcb9HI076ONtunRXt26nAA3/4esSK86pB6PV7UIsCuos8nb+4V0LlbkZTEr5SuKpBZSsItJFTS4GHopnyrLG4D1gkfEsDPEfc2MLwuEE4ma3S1BNqyo4Nvpg9GN6JbqsENbo/e2SECEukeYFiifbNm2Da+vIYNoCKQI5fM2iU6g8mhWsGOOpQX7kEcxZn+R7+T9amxT6Jg0grI2jDsoLB+P73sXpEdshJkFWFk7OSpVR5qIi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(83380400001)(38070700009)(33656002)(38100700002)(122000001)(5660300002)(316002)(8936002)(4326008)(8676002)(2906002)(86362001)(6506007)(7696005)(71200400001)(9686003)(66476007)(52536014)(54906003)(64756008)(66446008)(6916009)(66556008)(66946007)(478600001)(76116006)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CRUlqbtSCrVZ1lHOV6pH3r1YVWYE6ubQhqaQEMKglCMgxQFbmIyDOPk++N8y?=
 =?us-ascii?Q?MjxshvmyEE2FlUZps8hn1jjjE2lxVrj6tYf6Ff8+oz9JPiRGtq+SuaopO+1/?=
 =?us-ascii?Q?flTZ0LkBzsmCShiTpcTTVl090p9BWvFSGnoVK8vtYAuct6k+ecpz+eYYPP0f?=
 =?us-ascii?Q?0Fhm+uWlFIfCrrYyN1L2IDpdKZ4QVRgrDusKHLwGI7pW4CLPuCMSLnkL/ErU?=
 =?us-ascii?Q?mx+8SXsYJaIj4dX5PMUIYQZy/rEXgtNNaa7aXPgadT9i7uHjuHN0am8QUShD?=
 =?us-ascii?Q?OVQniM3Gd77fdzP+PVf3JYlpEwtrDl5Vmav6UHVD3yCcxPerpYG8Ue1jTOJb?=
 =?us-ascii?Q?mFH9s+ALy7kcOFm+jncF0YiWxeUvZANzGWZvaZi/2C7aPdVdBl18MKGtBhjs?=
 =?us-ascii?Q?NhqKB5UDERSI5RfCiXmedUa6ACevmHQ62PDMrKy40wRFciLsSbp/Qwfh/OxN?=
 =?us-ascii?Q?gK3YOU/QXoJx8EqNBOjORzRY2wMD99VO7GX3tJtWRvp/TKhfWH8V+HDRjC82?=
 =?us-ascii?Q?Zh11c+x3xpoR3AAFJVLeYbBa2T4LwfPxadKCj2QGF7RqixA1ZE76V480JC3E?=
 =?us-ascii?Q?P5iEt6OzY4HxUUk4mZFTqEcSrCjhp+MFq1bl247fQVjZuKVMAZvZfHhjyiUK?=
 =?us-ascii?Q?VkA2fogCPqD2I4aYFsDpcjLmxEmICRHS2lnaBL6qliNE0jnHZMocBI2g48h9?=
 =?us-ascii?Q?T49z8iTqDT/6lvfIqL5VFI3aZuz1/W9j/habQaEab25RSDEDqpxmi8g28Tbx?=
 =?us-ascii?Q?fWPjEq8gFoLjesU/3zdpclij6NcyA37rYYBvMHzZRsSWpeleKYQUnlDhp+Lt?=
 =?us-ascii?Q?f3ug5QaSedqcxJn+Uv2THx039ENx5m6Je8WaFGbFoJQ+je6NiS0XY+C66Bhx?=
 =?us-ascii?Q?N85PEe+13dORIuI0JFYAYQyAo1eqUcHGuU7H8LprlKRD7+ViAULSe6GtPmfI?=
 =?us-ascii?Q?uzg0VYeKwPVc5FlDR/9JCPvkJ7zek1xZT+InrfQpaDF4LTGHPRYAtQWuINex?=
 =?us-ascii?Q?X86EoDZ8R97cVbh1jtbEW3FZzz8T9s8FUxHlksvFZG31KSNUPp79stnurjLF?=
 =?us-ascii?Q?gvORCuFmkIDbpzMUuJZD7BxJpJTUxx9ianuZWfBRdpg64Sa0wfTn8XTwWF7r?=
 =?us-ascii?Q?bJi82Jsrzi6qz+q8mcxD8u6BJhMcCe0zqTq/i+tzl5Og3gWFXrMJ7bKPOYJX?=
 =?us-ascii?Q?9GUU2mNiPa0j9J0Dg5GfEXOuTOuh/0+aqzxVB+bdmQelgUxFUhvn7PBG8NPo?=
 =?us-ascii?Q?HqohJtr/usehoPoMpw6jIhNXdIo56FhsGU7VygkOpyzdXZSW8hs/RZ3X394a?=
 =?us-ascii?Q?aOrE+hVpoBPtfTNp/8yQYyS+4CpLqtO0VbIv91zQ8SfGI8CPyuoOrJdH6LgX?=
 =?us-ascii?Q?hP/mK6wrgM7WvfVypGLxWkmaC3LvOTatL0to/Zk/2bQjOs7tmrAEnVszcH5O?=
 =?us-ascii?Q?/Axy+nffRnXqirdfdGWkZAD2eT7S0nMs4vWGtfKDZv/u6ZZE+7JxyJZBRbub?=
 =?us-ascii?Q?BLQFSSf1MkCv5U4wmzDe7o+p9owBJYHT3+lSROSYMO0vZTbSSsj2ZWdQirNM?=
 =?us-ascii?Q?o7PB8VixpE+0F6Bda+gks6CaNKaotVAfwsSGEWmaE0Q/4WGRHhhEpm3wa7Yu?=
 =?us-ascii?Q?Z5SESVwv036XKIS8vTK/CAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d90dfe5-7539-4a8c-17c5-08dbfae37700
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 07:25:06.3449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dp8lD87OhqvUM1AN1C1/JDzJ24heKTc2Ugvg1rxArKPlIGUAOhPbum0kMJ4Ywz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

> Now that the zynqmp pinctrl driver supports the tri-state registers, make=
 sure that the pins requiring output-enable are configured appropriately fo=
r SOMs.

> Without it, all tristate setting for MIOs, which are not related to SOM i=
tself, are using default configuration which is not correct setting.
> It means SDs, USBs, ethernet, etc. are not working properly.

> In past it was fixed through calling tristate configuration via bootcmd:
> usb_init=3Dmw 0xFF180208 2020
> kv260_gem3=3Dmw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
>  gpio toggle gpio@ff0a000038

> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> arch/arm/dts/zynqmp-sck-kd-g-revA.dts | 7 +++++++
> 1 file changed, 7 insertions(+)

> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts b/arch/arm/dts/zynqmp-=
sck-kd-g-revA.dts
> index 56f3128528..ffdb60fa51 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
> @@ -175,6 +175,7 @@
=20
Please do not apply v1 of this patch.  I will making a slight update / corr=
ection with v2.

Best regards,
Neal Frager
AMD
