Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B146CD690C
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A978E86BF8;
	Tue, 10 Oct 2023 11:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GZn1augr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GZn1augr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69ABB86D59; Tue, 10 Oct 2023 11:26:51 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B90886BD0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Guillaume.Gardet@arm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61snSg12gs8gKnA0pxfFwUeDeo9GttXMgLOWd6g6brI=;
 b=GZn1augr0iOfbNqnBuj8Y1lpWyukyCZLn2IZYqEXKCq8fNe2yJ2olBZIIus5K5YWvubjbRKUuMeYSKbL7d3iEzEFwDwsqKbhfCjDNm4cbAMrXeWbGvB2CBwwNoQ3RZn8pUGWiakqdzjeMvhgzCbcwwDhQe2V1M5TAsaKFq9tYgs=
Received: from AM6PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:20b:6e::42)
 by DB9PR08MB8674.eurprd08.prod.outlook.com (2603:10a6:10:3d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 09:26:44 +0000
Received: from AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::f3) by AM6PR02CA0029.outlook.office365.com
 (2603:10a6:20b:6e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 09:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT042.mail.protection.outlook.com (100.127.140.209) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.23 via Frontend Transport; Tue, 10 Oct 2023 09:26:43 +0000
Received: ("Tessian outbound 6d14f3380669:v211");
 Tue, 10 Oct 2023 09:26:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7e418f8dee616053
X-CR-MTA-TID: 64aa7808
Received: from 04ccbbc99f86.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 A2458CB2-B239-440B-B85D-DDE72D63B1FF.1; 
 Tue, 10 Oct 2023 09:26:36 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 04ccbbc99f86.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 10 Oct 2023 09:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDTEuXfb9peOIg9Hmxl687i0SH0jFjWzvNkedZOtPqwCW3f4bLhEJU9ei+JrJek+1q93y5a81LSI6HZKlWD0z38LUtZ1bWrYmugg10u/QDPJ8mONjvSp+UaCHx8T1B/80ybaCoAHWJ7F8D3eTKpvar8LSQQaXDbJwRxBrDpwjKi/8npEre+OSErILFYSWLHx9amKyjw1Jdyi1ZWERInCqYbi8nMdv7L4jUCs3DDqNasMGlq8lico+Lr/NAw+JdbJH1pTw2LWihD2cBjgUyV+Zf8Oww0V3K6K04wlfAehmKckRd41RtXxJsyAQGkWNgjp4tstYMi7Sph6e9DdXleoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61snSg12gs8gKnA0pxfFwUeDeo9GttXMgLOWd6g6brI=;
 b=MnYQtZctUAa89o9acKNHK4IYqUnemrauGVU77lJ505XMxDqTRvIlul1fwR0Z5OxsOZDReLhTbrK1XUU5vjAaAD5IF7bCqe/g7zTqrUFG5Xk8qTNzcOVQ+bRx8ZkhO6gYFG0Ek99++ov/RNuoAbF29VwtLqcHHjG5kUQX9nvGpwJH7PHnPQ0EJRw49Z+BNoPQyy8XakkDx2325bTNaWFCuKosXttOQmtBNASnk63RIvotjoFSUPtyaN5tubhGISYTw4oXnYFIDqLa20vwbk2Oh1ru6pTVHTxhtYceUQbjt9fgeYQJKHs49PRVv0TIgbi8Bs8UmFav3xyoQyYEFoeYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61snSg12gs8gKnA0pxfFwUeDeo9GttXMgLOWd6g6brI=;
 b=GZn1augr0iOfbNqnBuj8Y1lpWyukyCZLn2IZYqEXKCq8fNe2yJ2olBZIIus5K5YWvubjbRKUuMeYSKbL7d3iEzEFwDwsqKbhfCjDNm4cbAMrXeWbGvB2CBwwNoQ3RZn8pUGWiakqdzjeMvhgzCbcwwDhQe2V1M5TAsaKFq9tYgs=
Received: from VI1PR08MB2847.eurprd08.prod.outlook.com (2603:10a6:802:19::31)
 by PA4PR08MB5917.eurprd08.prod.outlook.com (2603:10a6:102:f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:26:34 +0000
Received: from VI1PR08MB2847.eurprd08.prod.outlook.com
 ([fe80::a3db:b677:3bb0:fa47]) by VI1PR08MB2847.eurprd08.prod.outlook.com
 ([fe80::a3db:b677:3bb0:fa47%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:26:34 +0000
From: Guillaume Gardet <Guillaume.Gardet@arm.com>
To: "mbrugger@suse.com" <mbrugger@suse.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ivan Ivanov <ivan.ivanov@suse.com>, Simon Glass
 <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Topic: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Index: Adn7Wr0e+LRv6MRIS4aqQVJurtxarg==
Date: Tue, 10 Oct 2023 09:26:34 +0000
Message-ID: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: VI1PR08MB2847:EE_|PA4PR08MB5917:EE_|AM7EUR03FT042:EE_|DB9PR08MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 008d172d-3f53-491c-8519-08dbc97304a4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GKm4/BDqOm0DleK5ZLpQ/7LTLSRvDCt2294gmqUjaPVDzb/2uDcCGYLHXmKIBkiYrk9aDcDU3p1Yo9m3hwMPp7HWbtKzHrnf2gTnh8IkTsJJ71gsGyyQovd+RGQxH4XbCW4UDKjUDIh8Vx2r4JOUt8s63YHLK+WvMt84fXa/lNdLu8QVCwJ0Z2kkFAL/ZoS9L8fVHK1wfVebenSv0Tkgh34SqBwcfrLC3Xmk33H3/gMGiPLDUhdTDc5P+Vuq/Z1IPOY5TsTNKHocLUHijQkvJ2RyK/xfvFiEIcgzuJ4RxV1IgxMqjj31NNpZquUaan6mQzoBlLrmRDwPMWVYWadFgTMj3k5FPNxUlAKGcFM5RyJwq5+ucNcnpmcORAqvtBqZ4tlKAYmIJJ/+JeE1EyO4kakGvvgo5dB4vOaVf6n/gUNNY8iQTTTbOoNhwb1G92UUJNigYlfxAntpHJ6yW0NBls49ttazmkYEWcpgfaeHv6WPBKQhebz6embWtmyuhMs36czVcr39HO+CVdJ1jTNKyOoU1lviDYjGWvSZyaMIN4S5K0C/5njJoR3JgLCBbZPPgl6o9AHuHSUNrnHY6O7e7HdgjO6ZNywku8JbMaktBasmULjuboCMyHuJySPsWyZL
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB2847.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(6506007)(7696005)(478600001)(71200400001)(83380400001)(2906002)(5660300002)(110136005)(66446008)(64756008)(76116006)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(52536014)(33656002)(122000001)(38070700005)(38100700002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5917
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c2cefba7-6f5d-4269-b555-08dbc972fed6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxHlMRqUQ48lOZXaZCAeezs9dRlL0EqMnrNiidX6UEVUG7IWrr5cGu0CMxO/6CD0nBH1RaxdxBpE7soLhtMJoijujmtdgQQU04lRKfO/DalU3ntHH5gdpIQ25p6YJzmbhECvrUMH8kyzki05uV+wgpUVnVvWP/rD7racWStAPI4XWJg5ogeBO1C46FE6dG6cckcXuO9Y/D0VJ14WEFnmLR2skTQJyS6HLK5RYNEbpSl/a3gDmbEnFTAdFaUKPVoe9GAwlk71daenDSYzQkGgJSb3GJXnv7etAKo4JH4ybuiev3IFleO427iwmeckacIXBZUAbeoOOoUkrO4W8kd33bfMCHbDHaVERlNjEpzSSO9qyp+0faTRCqEd/GHIi+t/E5BMYqGa52Zf1YI6pXocXJekecAgpTWGA7rfqSn3YrfImW6frxzD3+1JzRCy+71FsGeP2s11Jj8x7OS2M0paQnS3lJyNJnbmWke9FtNEujWJPvW2qzxf10NKTfkQLOtIoJP8ikRXkx6YgsA3+DwTzfQwR+HO2GeSv9JbhY//S3AahsCZapWzQWVz7KV6mSj2dLMBgR/u54FPJqyaLfq6P88F4iWV6xPg8xOvMa7bHDijnInFhH35IlOiY94fn6WeeycTUfNguNJzyxbq192I8pdfbH8JE80z6SnDystEw7ruWAAzwZGLiczRU2RA0AJ1HUbqrxQ3B4uHakQoOLRllp+zmYKnzB49wDNBN28eu5X3XecwOPJ0S/WxEA9i0a7n
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(55016003)(40460700003)(336012)(8936002)(6506007)(83380400001)(110136005)(26005)(47076005)(36860700001)(316002)(70206006)(70586007)(7696005)(5660300002)(41300700001)(52536014)(8676002)(82740400003)(9686003)(2906002)(478600001)(4326008)(33656002)(81166007)(356005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:26:43.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008d172d-3f53-491c-8519-08dbc97304a4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8674
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

Hi,

U-Boot 2023.10 does not boot from uSD on RPi4.
This has been found on openSUSE Tumbleweed. The only diff we need is:
  -CONFIG_OF_EMBED=3Dy
  +CONFIG_OF_BOARD=3Dy
To use firmware provided Device Tree. But that should not affect the mmc be=
havior too much, I think.

'git bisect' points to:
**********
commit c771e5b8c2a186fb072b6c6f571d4a3cc86efba9
Author: Simon Glass <sjg@chromium.org>
Date:   Thu Jul 27 15:54:28 2023 -0600

    arm: rpi: Switch to standard boot

    Drop use of the distro scripts and use standard boot instead.

    We don't need to specify the mmc devices individually, since they are
    used in order from 0 to 2, and standard boot uses that order anyway.

    Signed-off-by: Simon Glass <sjg@chromium.org>
**********

The following patch fixes the boot from uSD on RPi4 (not tested on RPi3 nor=
 RPi Zero 2 W):
**********
diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285ed..02210b97b5 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -74,4 +74,4 @@ pxefile_addr_r=3D0x02500000
 fdt_addr_r=3D0x02600000
 ramdisk_addr_r=3D0x02700000

-boot_targets=3Dmmc usb pxe dhcp
+boot_targets=3Dmmc0 mmc1 mmc2 usb pxe dhcp
**********

So, the comment from Simon " We don't need to specify the mmc devices indiv=
idually, since they are used in order from 0 to 2, and standard boot uses t=
hat order anyway" seems wrong for the RPi4 case.

Cheers,
Guillaume

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
