Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7CFC83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 09:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E9686932;
	Tue,  5 Sep 2023 11:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+HF89Gd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972DF8693D; Tue,  5 Sep 2023 11:51:38 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB508691E
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 11:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SETdkV/zMenI5F8Qnq8sJjh/IXwTH3keaBpT58zqzcAofinwhSuV26MhGZcpyUD+KxWywVO1Ll0dn6B6Ewh2NY6uu6FbM2aux+Z3v0wyehvf9zveE0pz30Kih4hvHLntFdS+dY8d/x7cpBohBH1yk5dBJ2HGOtxgS79DQHrhyMVp3xLy81yJBA0ZJ+cQVyHlRP53keI00VVFtZrQaqDwE4uAl3IB64eXW+zgQBWVQiiXRJrGvTkSM0XcDXLKgkcK00UQxiW23ibpMfcbNNorrH5zT7gQMewvvZ3C3Y/cgMWnwJj/m40QaYuia0DmVpgNkXZVztByU89ralYQFTQgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLCldZ+0zs3RdiDyjWCxt4qTN6Yj+/21TO4yOYLP9XE=;
 b=MBv5A475qnn3V9FMyod0aVMMSuJqipKtz1LdT7RxO9h1gfKf71tiZr8JhdH/Zwws2ega0/qImFUEIY6qLtjpqByM2yrYWQ529REUqt336shKMvW15JCnEuFwdXoDOwpqeeMp98rF58ONbq0b9SawOKtyH6rmOeJ7p0E4sjH0i8D+IhdUssfYnXDFLKdwj6xDSyginLWlWlHK3djx+q5whhaxmCIUPZUtAcYukPbAMiDbxSxL1q/F6/D4RDakywWvc1PY34ZmZuop3MjMU0v1Ld93ILxOjq5rv5nvE1Z2qnfcfdNncSG0zLrA/cn8sbgeqHRYScMwhlSfdaRGI1CWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLCldZ+0zs3RdiDyjWCxt4qTN6Yj+/21TO4yOYLP9XE=;
 b=4+HF89GdL8pNvdpBNR6GoXe6VzgjPYcwVCSTPRH70DZG8rvGRaxnWO1u0V4sfpeadUuk2FjAfuA+Py8xW270cs2cjFs42q+6CiSLLXzkpLa6AnwVjULj5B1MgLOyaqk2IjYgod4XUjHr/Y+gbHUBEq4h3DHe3bMrOqmgFyynRnY=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Tue, 5 Sep 2023 09:51:31 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::95) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 09:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 09:51:31 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 04:51:29 -0500
Message-ID: <3c29d2dd-c7d4-80d8-df09-646196e8b7cb@amd.com>
Date: Tue, 5 Sep 2023 11:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Simon Glass <sjg@google.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
 <20230904032035.11926-2-venkatesh.abbarapu@amd.com>
 <CAPnjgZ2S6iz8KPG0pVn+XLkfK97oPSLVQcMCQeq3WNyHTZkJAQ@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/3] xilinx: versal-net: Do not setup boot_targets if
 driver is not enabled
In-Reply-To: <CAPnjgZ2S6iz8KPG0pVn+XLkfK97oPSLVQcMCQeq3WNyHTZkJAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de90168-9095-496b-f50d-08dbadf5aee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrbJ5OtIVXb8qmLnYO4+lPvWZWpS6ZfwY7RCPYfPmogSFkaMU/GkT4xgkauOdhtipJFmEilK80IHf2MTvPACGI8IKvhGmNZPpiKTKiuUFpP6eOp0vhg66QzUUtFUBlxg1/IlFA4Lst+B0MbyCwpekFYbVQL6UNc4lAr5haaBSfvuhd+cG5PBz2ox+cFkklHMbD0OAhqPJzyMocbTNcayUkP+ubvAg+CzAam5Vi6C+kvNl07VvUMpYJ2+fu15xUjzX5xWBK+POZ2zQT1R2Yi/Wi4Wwnk+jUebpbjTflALVU06r7DJiyKEuQFvbOjXOcfBFev2kv6veRGdoKNj36/tlh7/rfB8RXJYpjfBdWTC4PKHcOj0vr9CDGsyULttRtNGvJObUytQjIMktRcl3NZBjsJ0m2fLmspj3a8wcNSUb1M5jt0jTdqe4ksg+oLXlvK0TYiIkpt2HKw3ehFJvX6XlAAu8DOBZ0GSC4oHHYYasMF/Gs/cwHthhQdLEXLBl2Ag8voZh/W2Ho/gn9V63WsMBVLMmtf9V2WJn52I/lZai8APNnV4q6HV6X2jg9k+/zT7L0JOm2oOc0jsGtr+SbblpImX6pbFeLSINSccztWbjNVyhn4/xPxPKDH/Exuf5Xp64uTRgtg1pl0D5fRz0Tn+3feeFpOKf756BEqk1FCrn6urlDApMRCT9fX/Bh4qGElSlEYEZhlBqqJxRg4Vs/gqyyYrYtVo0m/065pxgzLeSNSZBmNWFb7hOrkF93B8G4rDSlWLXH3Jjh5m/dRDKqXXAEeGxv6HBuyMRgVgHGl4n66OFQgG84xXykF0N1nf6vMd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(356005)(82740400003)(81166007)(86362001)(31696002)(478600001)(83380400001)(2616005)(16526019)(107886003)(53546011)(36860700001)(336012)(26005)(47076005)(40480700001)(426003)(70586007)(70206006)(54906003)(36756003)(16576012)(316002)(6636002)(110136005)(2906002)(44832011)(8676002)(8936002)(5660300002)(31686004)(4326008)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 09:51:31.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de90168-9095-496b-f50d-08dbadf5aee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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



On 9/4/23 16:43, Simon Glass wrote:
> Hi Venkatesh,
> 
> On Mon, 4 Sept 2023 at 07:58, Venkatesh Yadav Abbarapu
> <venkatesh.abbarapu@amd.com> wrote:
>>
>> SOC can boot in the device which is not accessible from APU and running
>> this is detected as error which ends up in stopping boot process.
>> Boot mode detection and logic around is present to setup priority
>> on boot devices that SOC boot device is likely also used for booting OS.
>> Change logic to detect this case with showing message about it but don't
>> fail in boot process and don't prioritize boot device in this case.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   board/xilinx/versal-net/board.c | 76 ++++++++++++++++-----------------
>>   1 file changed, 38 insertions(+), 38 deletions(-)
>>
> 
> If you switch to standard boot it won't try to boot on devices which
> don't exist.

Actually I was looking at standard boot yesterday. We have enabled standard boot 
already but not BOOTSTD_FULL because there is a dependency on having video 
enabled. Actually this dependency should be covered in Kconfig too.

I don't think this is an issue with this series which is trying to address issue 
properly. But let me send a patch to guard this code only when 
CONFIG_DISTRO_DEFAULTS is enabled. And also that huge amount of variables don't 
need to be created too in this case.

Thanks,
Michal
