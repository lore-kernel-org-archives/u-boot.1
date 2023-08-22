Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3701EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A7786486;
	Tue, 22 Aug 2023 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="LxEpIGXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EB98646A; Tue, 22 Aug 2023 14:59:18 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A7F86386
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuGGbeSfKoCXXMAD7YB728fodiZsTrdAWG2AwuBmgkgbDeG0a2OTVwGbKDOE4BDjn4OuhssHvVLC1ukAEQ9XMd0Knud+CbT9m56MI3hyb3BZwFh+W9TkMIp2xf/kHKR2KZQ5xgecpmO0tNmSWcmsf74Do8y4Mhh4xIBTU+yg6wE1BaueCe7G4O8lR5pIvglv+uQ/wq9UCgka/yqKGF6M/Krs1AhkNkQoT9MEdzfrj829E0r8UP+iJriQI9pTrcEQ7/0NO040KFIKe0TL39shURkKE25jjCHeBauQQx9Rf2Wq0jiWunKkwdVrFo7gro2yXFl5n3fKd1pFy2P/z7zfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhP6bQT/3BouziSZMJairp2wn/OBff9cpvs5EiQWRNI=;
 b=jfqnXDNMxloafYBNu3VqKVr7ttz6B+FHBntT0ZMW02VthDjoX98fp9dvvzxbUUHOE8JOClpf+cYNZH+E/pE387XrEhzcTVb1WvWDjJ3Y//UQ04OVN4V3/XUngo/um7iw3sQqZX+D8foUuzJ0s1BeHecea4/yASnAhQ53rA+PgzfbAyQtT09mbDSJqDmMgK4XZTbjO80BMUPR9lkJ/rOP8bK0hyg5qk+XZH2lYQ3uKYbLmA6ARxx6xBePl2SsGkXGQrloir07iaDG3ESvMJtVasVEy9cK3ES9jWtqfX8GTfqV7GBwufAG+odDpkOaGYeaCxhq5hxn5uu8d6R9WvJ89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhP6bQT/3BouziSZMJairp2wn/OBff9cpvs5EiQWRNI=;
 b=LxEpIGXMmtQbBtpDDwkJ0p9q6QodX6yd6MsZrgWF4PaRZu1Uuq7hMOIFd59KDhE58gI2Ce8/gD2X4iTT8H0Mtn/rs5LOsIR3Pu1qlMAQSEo7AWkN86gPBEEDSW/RBcKoSRCHNCro/yZe3/t2V56eKYdy8zXzhagv5FF1EpewHIeu22E6um7rUobz33aoI90k5OlpBBjkPacWgjIBjPGI9FOHxV2fXB/Ni4YNE06HB4w6HuGIVb4OpEcBpYrsDdCwIO57bJNLQh7Lh2arLixojDDghElBkSZDsg8s3Fo4LcxIxEuN7XRJnQ2TagUgEIaPPZ//k6smsI4WiH6awsptFg==
Received: from DU2PR04CA0256.eurprd04.prod.outlook.com (2603:10a6:10:28e::21)
 by AS8PR10MB6921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 12:59:14 +0000
Received: from DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::a4) by DU2PR04CA0256.outlook.office365.com
 (2603:10a6:10:28e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 12:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.199 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.199; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.199) by
 DBAEUR03FT058.mail.protection.outlook.com (100.127.142.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.15 via Frontend Transport; Tue, 22 Aug 2023 12:59:14 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 14:59:12 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Tue, 22 Aug 2023 14:59:12 +0200
Received: from localhost.localdomain (10.34.189.209) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server id
 15.1.2507.31; Tue, 22 Aug 2023 14:59:11 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: 
Date: Tue, 22 Aug 2023 12:58:56 +0000
Message-ID: <20230822125858.8018-1-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.34.189.209]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT058:EE_|AS8PR10MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1c6400-50c9-4335-1f8d-08dba30f9666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIMjc5ojVFA7Np8M4yBL9+mSFoxajR3XHZpRKNQNYFz4AAGULC7XERxD41wPkNaH8GoqqKKDlOj9LO8T597Vp3mFfyF/fzpc6ZKfy73e2mp2oeljhRZgn5ZiqV1JR+Y9l6TqrZGzDF8ILQojG5obByA7i6Lrzaq6AWvSV14ChNlnmZ5LWJH+8k96QctViqXoTEEEFKbhUCkjxa85CaqyAfCoyjQB4LpMqzW5bXuzvK0/IY11TCy5+J0eDOCHoCTVQScOIwpbq8Kh7vUOPyPeio3aQrkUN1st01xdWgCkwRwQJdZ1QJrQHjLvDU1MAj4euw1EvAy3tXGK8MUc3/7vCPtHVPDj4ZCzzXiZE5SXse2Yx4lhquyR6tMqKW7vWLxIRfSn4dXWH1rRdZYq9oYSQOLf87dNGjc71SgsBLlD6EZ/a/R5IbG2Mufn5+oJlytPvqfUyTdXQAMyx6ndeQ2oU4OjJxP43dfx65R7J6LCOKb8D6cpxo03sgJ/OM6UyRcYWgx+qpSXKWClAyXxfX8UDvymr5KXt5UQJVInejBFKB7s7OBQnDr8bQwsZOcm/itKEOarGZlESQBEGJObLsWkQ6T0+cVrywMnrGDcE28yLD65L09kVs/TcqlhSAepkMkkwgimPAWBdJuLps1Gw76j62Gakj5yBI/tlBeoy96KvhELXJa0E9SXuBzwpQD84v1o4bgiipo7hRvxB2BhoKfpr+hGapOR3R1sceFlJWtx2Hj5oboxAmomRs27OitP+brzuXloFJNpjOgtOvaTfAKHtpar2ifSIkxhEyO6waOg1/53deF4s2yA8E/FLHNGyBBK
X-Forefront-Antispam-Report: CIP:139.15.153.199; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(316002)(70586007)(70206006)(82960400001)(8936002)(2616005)(4326008)(40460700003)(41300700001)(1076003)(82740400003)(356005)(81166007)(478600001)(6666004)(40480700001)(5406001)(558084003)(2906002)(86362001)(47076005)(2876002)(36860700001)(336012)(426003)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:59:14.4450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1c6400-50c9-4335-1f8d-08dba30f9666
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.199];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6921
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


Changes compared to V1:
- Some reworks from findings of H.Schuchardt
- Partition setup reduced to 2 partitions

