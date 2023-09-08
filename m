Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A34EE57CA
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 06:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F0186564;
	Fri,  8 Sep 2023 08:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/E9AD+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5D2866CF; Fri,  8 Sep 2023 08:30:47 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB3186564
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 08:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOpcbZ4+SQsEDXCewruXzpGAEiEdxTS9hMalaTh+K/y8Fo4r4w2rQrqMAjW3YN4tncbL7dZZi6u40zMlbgqf3Kwq8rtYi+tdIH9f9bZ+ipy3MyexyJaVOx692yd0x6RoQolfpzyqkEtb1fNUL5kcjNAJ9OH9tV0D1Z/cv7ZWNsc6sCx7dInhePA6dhPWMkKbvT5eoZqbNHgV3PVI5mdUlLIFIuCuBadBoSH8izyCwfxvakEM/lsenp25cbWA73IT86FzqBpKU/bO3RsEmSOIIKamtPtF7I1PKBWD+4+t5GxB29d9fYNGkFk+hb1EPXFvqYMmIc24Z3n8q/nPXKFgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y52gnnQtDmcFy5UGa95YoJ0NTjj9xH78cuRiQ0+zVEU=;
 b=PqhJcANcfFV0hhNHiJ5tA7mzBsnMiWAYTYW/16eU5AziGvuf1ntVErWXowmXjbN28s4xGhxULdeCFOTjzSWqj6QYYINFsNVzVfJiQ6Vz6vCkFNrq6JeKWjLTipZnaNmNu9bE1LG3Uut5nRqdOjZ7YY22X8GABbuCLNE+xKttrlKaqHJqFN/yay2+5KmjjHh0qTtBZVpXi6+NXADz1IvaH2Hvjln58CRjVtRO1elPHUs6Lxs3oE/G1J8XWIetHXNiby9PLZwdEGEjTks7bztrdW2L2agVHMm7FavY/9fx5YwVuFsWiTCuEMgwyFMhhLNaLEB5NgMaqfeZNFQNTzOqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y52gnnQtDmcFy5UGa95YoJ0NTjj9xH78cuRiQ0+zVEU=;
 b=k/E9AD+2sjkuQo53oKEiFozGbYEB0UQnq26wCUKRNmuEnZpCdWLv+4J9SXm+ug2U1iXHmPX09Xp1agBkjf55sh53tjHW+wCztknepv16oOBy5rd7xEWLLL8eiYrBMil3GMH4/5C6CRkS0Oe5BLpWZNuVZB5+Nns2LpMIlQkvEYY=
Received: from SN6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:805:66::32)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:30:40 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::40) by SN6PR08CA0019.outlook.office365.com
 (2603:10b6:805:66::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 06:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 06:30:40 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 01:30:38 -0500
Message-ID: <c7207e0f-ddf1-6892-b77c-9830ecb0cd7f@amd.com>
Date: Fri, 8 Sep 2023 08:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv7 00/15] net/lwip: add lwip library for the network stack
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>
CC: <u-boot@lists.denx.de>, <pbrobinson@gmail.com>,
 <ilias.apalodimas@linaro.org>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <goldsimon@gmx.de>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <CAHTX3dKEqFNMQf+-FSO7oZerT03fQb1Z1BYvN3-dfpmoPtZQFg@mail.gmail.com>
 <20230907192327.GY305624@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230907192327.GY305624@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d45ea03-01a1-4bec-1d16-08dbb0351eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WS95KXgyOoBtXrruZ8TSFay8t6rx6DC0LQKSyf9vpvsb05MNw6d/XsSZbI3c6orxcmWGrpYFOfeR8Huvd0XodYOpCMlN8s6V2r5+XbOmDwsZ5TQea2wYIhBPkCvLNaWmuTJuy96CXuk4sAttewat+8UhIkwcIoTQo1Y58a/YKXnJMzw/EIfFEDhmVBjKzELvMz1Ji/K5RPh0pNrtmPhMN1vl5W42qEiwQhYbnkIMO6eA9DNjxSZfh5DcFyKjsQtn2OpJcGf8WDSrE5v+yneEf8D9j8CDx+Ux1gyJ0ZsMOydbkuXfadfVPY3quydTKV6x0QwoGSKpgxVl+YuhkWygLkb+2we9NjAcETN316Y0he5Agt/MthBBrPnkhQrFsU3ip173idR77bbewQ1MmoUM/GukAMzB+UJLUqKvThse2Sc8Pfsn/7UfmQGeqjrZMnXf1OWsdAaTEpydgNb0nNRH0opjAAQQ5571jvMH4pryWcSLFt2lMNeaSAl6Y2iS355ayS1Efr5kY2ZyRQATavDk3BIK+g9VlYc3V3xBx/wxkHAzcl9ddqdbINg1KRyPaIPYVqmyFCP+35V9t3Gk20AdCNLvcw0EZlwCsjy+uf4etMfehhLYtnzTuVHMWiffGLh36DGzGXI/BLhI2G1CEHNVE2h7958eKmqtiY0SJRDm0ad5+Cxuy3hBoT464puUOKwC+k7H9nmxHrfn9blWHugul/WRSfGNUdXuVJlJlDTPEmNQflDu7mcJSd4J5P0eO7uJ3cWMlkt85Wz9UfOj/gLUU/rK2AuJ8ipZct3ZNVUaTas=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(110136005)(53546011)(40460700003)(83380400001)(41300700001)(478600001)(336012)(66574015)(2616005)(966005)(16526019)(426003)(26005)(2906002)(54906003)(44832011)(70206006)(316002)(16576012)(70586007)(5660300002)(4326008)(8936002)(8676002)(31696002)(82740400003)(47076005)(40480700001)(36860700001)(36756003)(86362001)(356005)(31686004)(81166007)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:30:40.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d45ea03-01a1-4bec-1d16-08dbb0351eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
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



On 9/7/23 21:23, Tom Rini wrote:
> On Thu, Sep 07, 2023 at 05:21:18PM +0200, Michal Simek wrote:
>> Hi,
>>
>> út 22. 8. 2023 v 11:38 odesílatel Maxim Uvarov <maxim.uvarov@linaro.org> napsal:
>>>
>>> Hello,
>>>
>>> I'm sending v7, with all v6 comments getting fixed. The only thing left is a pointer
>>> to timeout callback which 2 applications use. I will rework this timeout
>>> in next v8. I started take a look at it, and want to fix this together
>>> with background applications support in v8.
>>>
>>> changelog:
>>>          v7: - more review fixes.
>>>              - support of multiply eth devices, were "ethact" selects the
>>>                active device.
>>>          v6: - fixed review comments for v5 (thanks Ilias and Simon).
>>>              - lwip is not under /net, so prior applying patch following
>>>                commit is needed to create lwIP merge into U-Boot:
>>>                git subtree add --prefix net/lwip/lwip-external https://git.savannah.nongnu.org/git/lwip.git master --squash
>>
>> I think you should integrate it via .gitmodules as is done for example in qemu.
> 
> I _think_ I am leaning towards subtree, but it sounds like we need to
> make the initial build easier, perhaps some Makefile logic to see we
> haven't added, and then do what's needed?
> 

Definitely it has to solved without any manual step. And this is enabled by 
default for all platforms. I pretty much think that it should be disabled now 
and when tested properly it can become default y.

Thanks,
Michal
