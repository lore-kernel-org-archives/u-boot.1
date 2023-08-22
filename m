Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06EAEE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11D9864D9;
	Tue, 22 Aug 2023 14:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="FYX1EBrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCBF86508; Tue, 22 Aug 2023 14:59:24 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6F4864D4
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOHvWXCMAyj4Drptl5Zes2lED7+NdUU3GeUW58hYt/YK0Z7LGWoUP1I2r7MGko1arg60/ar3EQSOF47mUsNM+9qH8083DEcq9tPitX+KAeZcA4lJXnjALidWtdcJpXNQwD2s0KRdyG1Q+tbH7IwNh+CHFP5tS/KfuG4GEk9vtt8jZAjMt0luSI/m8LFrXRQzwBjL8lKsmaVdFZBwR3MLW1aLdtWNKPPG8SK5c3JAi1eYPxnj8OHr4innOztURnm2OoHrIOXSpryiGDcmcZMW37xhbrgvPShAZkmYAZ1NAk5uDTJ/DJUrem4NJWLV+PmNtAIbQtftfoJQB9KN7XG+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqy4M6jtLBBd9MsvkABTlaHnCzfeELgdsq5RFtfVU9M=;
 b=JjgTHZxOkZe8YUnG9KJUFAX6Oomx6xjYIo4wT8aFU/mqgdevZ+5q9mZeWWpX7bBNtO4RIgmi7Eb7nSy+j2pUZoTRFZOI3ydB2xX29CVeHim5DPzOMhQWD+E6Y4a23zx8pbQ7Ra4l+NPXOiul/LXmHVyjutaBSabI/iXwmHHHQ5QqMJFhKsQFgfKf++Wabrmp2pwTNenzl3QmG2Fsnyk2bzJVQh8bCVH2pgAU8XExvXywlo+kKPrIbfgCDLnj7dpH6B1OoSZZ6K0pbvTb5RUU/PavvMeN46JNBQSpzVONxL56g+LvmFVfOWbjggBrCey0bEwJrWo7MoQwKYJA0GbgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqy4M6jtLBBd9MsvkABTlaHnCzfeELgdsq5RFtfVU9M=;
 b=FYX1EBrlY2BAWMaOW0G5jI8Ocse1CzyDQ29wrm9naSbRCqcKfiKL0oKdHEkPQbMleBZ64xsDkHJOMjyHZvAPoOuNbgHLnmXWyBPX32JnCxOIGX6xGr0K2Hg9Eqdm/fzhbJQBhVjDQ3XkB4cJ/Iy/zSTDC5tCEhMG4U5/fpRMB1nkGrVALxoFF+Zd6f0wckEca1p3LVlZ/CbwGVBVcRwAe9vXJEV9yG/EzRGSc8BHNqLAhM3mlJZ1k58WSOqyuswCCw54KflmAGiHe6vVwTZhsZm/NI8jXhtt8iuM1y6k1RRmsxUnO0nskyHGENHdEQSTx3cBq0jiJizawFoQ2MHGRg==
Received: from AS9PR05CA0111.eurprd05.prod.outlook.com (2603:10a6:20b:498::32)
 by DB8PR10MB3723.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 12:59:18 +0000
Received: from AM7EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:498:cafe::c1) by AS9PR05CA0111.outlook.office365.com
 (2603:10a6:20b:498::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 12:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.203 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 AM7EUR03FT011.mail.protection.outlook.com (100.127.140.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.15 via Frontend Transport; Tue, 22 Aug 2023 12:59:17 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 14:59:13 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Tue, 22 Aug 2023 14:59:13 +0200
Received: from localhost.localdomain (10.34.189.209) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server id
 15.1.2507.31; Tue, 22 Aug 2023 14:59:12 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 0/1] *** Documentation to set up U-Boot with VirtualBox ***
Date: Tue, 22 Aug 2023 12:58:57 +0000
Message-ID: <20230822125858.8018-2-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822125858.8018-1-thomas.mittelstaedt@de.bosch.com>
References: <20230822125858.8018-1-thomas.mittelstaedt@de.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.34.189.209]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT011:EE_|DB8PR10MB3723:EE_
X-MS-Office365-Filtering-Correlation-Id: b97c3fc2-9ab8-4d96-21bf-08dba30f9876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhig4GTZErl8dI5BUBM3gGrcEuJI5+ND1X/cBAhmxMzMnAiu0FDBaL6F6DJn4TTFAOEYhWJw9R4Up0bzLW3f9Bt4GfP/sWvClAfBSVPaZ0lHB7sXGst9Sgj6nYowZ+DJKZOrqFR5ZTFRxBqptDPnpU/TeqPjHflu4JLVXIS2kXac2zm/wDxUdmQrL/G6AbKcMh6qQt5d0vfBDsx5d020rc5uT7fS7m6y/KQg/I5sC9C2aAPNe2EASX4TRSqFxwbd9bIFn849pcIRwbAjbdKHARUQvWrQOg92M37P8x9kBq3f0GLXnmIPEbJQt0Voz2c50X5tcU4CMjTygJc4gZ07O+kSoJ8JQq1RIYzQ6Qw5NNdcCx0FKB0AKZrFKpLuBOKkFN4EJkL309yp5NHelLsENKHuWZ9KLtlhR6j1dzlQ7Kpk6PJ+2hYHPIjm4Zu6Np7RN406GcxbRJUxleVqdlncTUcuI6sCpv8XgrRhIYjpv2NX8uwGMazEdKiOIwt2PY+nvFYfxo6IsZCPZTlo0UpgkhM53BwFOcRmO6GVVdhdyHFpTsBgnMjHT3tAFqSmzfhDVW3WOXLzf940p+BajFQFbVEshFVhGImZfbWrNf0syI79fCIYK5OEDbVo4qHTmv69/qsJo3yIGJNWc3bEl+R4IEcwKEDShAbt/2T55XBux/U/8kXzGlzylIj0tiED7nEO31byoeaLfvlCuXNqXUUm6ISS21Pi+ynOFgIA821HwButogGi5YamWJ9uFY1QXLMHBvneeSs9qcSkKVP/LEcEPkxjVkXaTBS0DeVGMmVdQ5eM+G/szHngdcvT4siDF5Qp
X-Forefront-Antispam-Report: CIP:139.15.153.203; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(316002)(70586007)(70206006)(82960400001)(8676002)(8936002)(2616005)(4326008)(40460700003)(41300700001)(1076003)(82740400003)(356005)(81166007)(478600001)(6666004)(40480700001)(4744005)(2906002)(86362001)(47076005)(2876002)(36860700001)(336012)(426003)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:59:17.9991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97c3fc2-9ab8-4d96-21bf-08dba30f9876
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.203];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3723
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

From: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>

Changes compared to v1:

- Findings of H.Schuchardt added
- Partition scheme simplified from 3 to 2 partitions

Thomas Mittelstaedt (1):
  Documentation extended with specific information for VirtualBox

 doc/develop/uefi/u-boot_on_efi.rst | 84 ++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

-- 
2.30.2

