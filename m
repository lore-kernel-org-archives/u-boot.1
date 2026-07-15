Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D095FC4450A
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CED84B0C;
	Wed, 15 Jul 2026 14:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bmnaSxRz";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fiT/tcY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D39284B43; Wed, 15 Jul 2026 14:48:29 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB84984A7B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FBfcxo805634; Wed, 15 Jul 2026 07:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=z+kubNZxikWJ9Ei0CKQEFOsbARk2A1NbOn4H4d3V8
 K4=; b=bmnaSxRzOzAs5Z2bkOzAks6AcfLB/iIMjeyETjomCGdOeYwtfDkQB1Kq6
 1mqcVZCqLskAsNIFwnjKWh19ybxn0ivivEqMw1lVroxHgihiseRgOhixl0XQH0wC
 FNhL9FrYV08JuumvVNMqefhP4M4XXQRYpQKRcTG1B8hQdw93Z2ZTTGt49BYn+IhY
 Qx3oyMrNgdKPXyRJ2pmBUBsIveS8SKSwN2pi9K9NGBTuieM2vO2UDX3AHSkhWq9D
 zL2SDbo/VXsMwapRFoizvw9/DSF8rEgTuKRPsT7lIQdAkRISIv/ZDLjom7r3K0Ds
 tSW1PdMqOK4v4eUHeQGtxY4zPoT6g==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe9jb0fcp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 07:48:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5+A5PNRNVZaBaxKODNP9Cyag+Fvk+BY8JvIRNQuINAzaf9TdzXHYPi/rcr7k0VctOYOJitcnjwYuNzURtrBFoGAJDiNWyRIZSqPHHMLY3ZJQly1GabVtGa/zHTM07llJW419b8G3akkMkrhimOWBPcL8W7g7zcXTGfAI8kbt3BBgTU6A96GARjx6o42Zue6/BPM4zVnpIb7LTO0z4hSi8ZBJqsL+Kav+tUaqtXgAB2vxkPcxNtedPFU626sq/UbXBxmnuPmnfcgMZL3qZzy85wpdMsugF6f4FaaMm4DpTOkUCcAfPRGTPWian1rJyq0mOXBziBaOaQcdX0MYtEBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+kubNZxikWJ9Ei0CKQEFOsbARk2A1NbOn4H4d3V8K4=;
 b=vroiZxyLXH7az25GRrqZncvvmjp7bb4i70PSEkW/rseBOGaTMxdD8e2OIoJSGv7DlwC+yFDaqPkUHrf5+cGhr2sDFjRghfriP94HoJNuB8ZHeilIUOlHrgzJebrbu6kqHO+EJSpPDZcG6I800+AzSNi3duxIJhzsOcvkjuuErQEKzhcX987k22I+DbrfDSAKpJXPJ+R+ikgZ5/TjrxevDMm+2xStFm8ZnE+xyCnlx06VzdfwqWVNhRxGJzHFxjS5p0fQmmjqp8i3IFslsLOZVcsYZTj2FagUDMmex2jU+cnKa5Kwf3VXNqhgpT9bZzn2xy4+LQ+TH8cTjjW6eE2ASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+kubNZxikWJ9Ei0CKQEFOsbARk2A1NbOn4H4d3V8K4=;
 b=fiT/tcY340S9ZXNiVmS8g2QpBb3SCkEPPvGPi6eikxUVHR3mPviemaiNmmtzxu6H3xZgkRarQXRUsntmDlR7m6LB+bIgq/CiiXgK4+phpq52LmXShMqTKl21u/0G/n2LQ+GNT5QvuLwxKpkdhpQlh7E+YCQWK/bMesmjNC40IQk=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by SN4PR10MB5606.namprd10.prod.outlook.com (2603:10b6:806:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 12:48:18 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::18) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 12:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 12:48:16 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 07:47:51 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 07:47:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:47:51 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66FClmtj2490716;
 Wed, 15 Jul 2026 07:47:49 -0500
Message-ID: <47d3cced-d370-4dfb-b18a-e8563cde7e9a@ti.com>
Date: Wed, 15 Jul 2026 18:17:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Enable Ethernet boot on SK-AM62A-LP
To: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20260710102229.2980029-1-c-vankar@ti.com>
 <DJZ104DFNA3L.1JQXVSDWG8IFK@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <DJZ104DFNA3L.1JQXVSDWG8IFK@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SN4PR10MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d28e83-0fab-4b71-5223-08dee26f5771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|4143699003|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: AtxFalA/xinUezdOJYnE5Y6L54sar23hEH0/lpXMFcCIwskQUmOo5AHjo7LH1SsbiaHk9tZWiL/qcbwvhtwk/haJwzkmB+0U/5YT8hwbj9Ncgn7Uf0rpsyLwtKXVXjVNnAE4f4+QLnbtsBcHrRy9pbd5N7pAySgqGod3TxAlADHxhUay5Rptc8C2A00KGv0bGen2TE9w7jSpTI6kQUHeukQOw1zvsTD3DFIrdFRJpgy3gHVXizb0DspvQq3mZyL/u1WHXDhxeml8gG4bXeSevogwkV8qFQThOpYDO9Kust2ah/VqmdAdLRYLYC/m+NPx5y29c2y5LsS8PZngA41suNpvIjxMbDHlM0cToav71HrAilWj0qigZ6Vb5RazC5oMTOAViFqHtCSUFhPmKZ3ESHKLAYqyXFIpCq4cWPLwiuKPWImLJ9Tdbbw2Sy1h2rGmbKFnfTGsWXcKUVLdD4O6A8yHI10vGuj/XqJwVjosKfAerbVjnQOdONgillnFTwj7MWsPJU/6Lpgzf2i86PYX3ysvm6NhKHJ5qJTVwS7UFoekpFAu6DpO5/3zMGTPe3pwJCnGE0xCQsKnRFViAbI4yxEnvDQKhT2jXld/2QwXTB88NylcsVFYfVbuBIDhJdiGAoGUKgOd5yLcTIu0gtUR1KfPjbD/FCkJVHe3emsRoFMwv/ScqdU32tuDHiW7Tf2mwQpr8xd0yTZ0Fjq/vR1W6g==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(4143699003)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5HDZfjp9I3oSlgS0wOlcEieoda31y2xupJaPZiW+Kcx7nuc0m4cO0rxgQQzYvtSTNd2alkSeH0zTDeZ4e2T6DST9yqcFIyx+j3JWsro8OIEVJ5EezbrqQZhRfuVoRBEgYbtDeROAAmrKJaXqw3x7qqTAHhHYR6TkVgTK53/q1mToZAcnHsbqP28DLHQgt3zR3SGh+OoK9CxgoauNM0RgQc9qIIJHUtUYZlefTeVQBYI/6fToS44eMfjM0jbwQsHOVdu+M7KIrDtvuL9/CjB1dfJfJp60iOyzR/posiplI3B9XjhSN5rOSo+cET/7JnP762UQhV7ooProytdqIqxAKorG4tsF3iapg1GyUYsg5A3rPzcGXwSTYPhRQQNNtwECiYOzw1nYkGZXMpBBxevrovPBlCeR6zMYTWOr+awIIcCa0V9OWqmLL4wEdXvPXdlW
X-Exchange-RoutingPolicyChecked: jC9aNoboq9RXb9iq9hE0vJUK2bQu5aW+tMzX5fTwiruYYTiU3oXbsiOcpEgeRf2RwLqAskcliwZtZzJI5puy3QV0VEFFmPe+pV5QXybVzeMngR75J2fF/kwq44ntnetlMiafu/TbK5QmiTDsQPbyWcd/btNYbKUr/5IfuopQ1ydsAjDTWyg3rJczonhFRQBmOUfEYy7Ufwdu+7tpQJB71f/ZJ4mqX4+FANLJ39v2V93HZmZ9zwzRBgrL92XZzxud5xaSwWHnZVZFoEesfDAQAOC6ldGvvajvVK7UBt20jNz66TLUnxOI9jRapYoyES2DEWtKlYziSyv/9tMdPoUcoA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:48:16.8093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d28e83-0fab-4b71-5223-08dee26f5771
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5606
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNyBTYWx0ZWRfX4kN4PM07RSE0
 qK49ltTMaUL8iDYYYYyBVa2gevQWqXLyQnOlz5P/0uqFogvor1Wrqa1HHclSn57FOlt4uAWdVxx
 PkPgjZ6WcUsgvQfIiZuXJPkY7mJNnMt39/m3elLVz4kc01bj2NMSc30sesg1U/nM/USWUTk53qg
 OVtucBf3Tfj5hpU8uWyDU6c9JnW7xhCuA+TcvBAEmIaYj/4Pjt8XtHDxWHc2WnNr+ewSBFoK9Se
 Kfu1mSrjOBrfTz3fFt1GxY89yYl38Yi9ZcMePF8wEmx4IhrHZAJmki2y1Z1Xs8dsAC1weoDdk4L
 /E1GO8ghrv2nAXjiwYPkNQf+8NGzzv2+RAv6etk2iBh7ppA79yngnhjFNsU6MQIGczXnruJUHvP
 LqQp711ijMV7wNlobsgJtvYIu4rfStU7X+pzaD6cUfkE6JZjQRY7rXOnUsrWE09YJ6pIasLZAdY
 zaNjX5ZcolEDAcm4U0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNyBTYWx0ZWRfX4jZsHfe0uo8f
 xdoxlrQAgdWnIbdSw/jj0zltIp3RtQd6QN7udGfX8z7s3gZuhVWa5VzQ0ecwHtlxW/Kwkua+IRw
 xrOiwGrzdNspoyX99kOihe+alCJRHjc=
X-Proofpoint-GUID: sUanemQ5S8NLIGjuIqU98iOG497VDjAg
X-Authority-Analysis: v=2.4 cv=ROqD2Yi+ c=1 sm=1 tr=0 ts=6a578198 cx=c_pps
 a=5XdDR3/zV2dQAmk0xmzXVw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=zFwAhFH7b_1eIGe0l-cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sUanemQ5S8NLIGjuIqU98iOG497VDjAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150127
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

Hello Anshul,

On 15/07/26 14:39, Anshul Dalal wrote:
> On Fri Jul 10, 2026 at 3:52 PM IST, Chintan Vankar wrote:
>> This series enables Ethernet boot on SK-AM62A-LP. The series is based on
>> commit 'a18265f1ccb7' of origin/next branch of U-Boot repo.
>>
>> Link to v1:
>> https://lore.kernel.org/all/20260702081251.2691159-1-c-vankar@ti.com/
>>
>> Logs:
>> https://gist.github.com/chintan013/db875ef8b703094af70ca681659ba7f0
>>
> 
> I forgot to mention in my last reply but with ethernet boot added, it
> would be helpful to document it in the respective board RST as well.
> 

Thanks for testing the feature, I will add the documentation in next
version.

Regards,
Chintan.

>> Changes from v1 to v2:
>> -> Removed the duplicate config options from r5 and a53 defconfig.
>> -> Updated commit message for [PATCH 1/3].
>>
>> Chintan Vankar (3):
>>    configs: am62ax_evm_r5_ethboot: Enable config options required for
>>      Ethernet boot
>>    configs: am62ax_evm_a53_ethboot: Enable config options required to
>>      enable Ethernet boot
>>    arm: dts: k3-am62a7-sk-u-boot: Enable DM services for main_pktdma
>>
>>   arch/arm/dts/k3-am62a7-r5-sk.dts         |  5 +++++
>>   configs/am62ax_evm_a53_ethboot_defconfig | 10 ++++++++++
>>   configs/am62ax_evm_r5_ethboot_defconfig  | 22 ++++++++++++++++++++++
>>   3 files changed, 37 insertions(+)
>>   create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
>>   create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig
> 

