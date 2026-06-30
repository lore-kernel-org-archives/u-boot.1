Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0782EC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 15:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D729884A3C;
	Tue, 30 Jun 2026 17:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="df0+eYA4";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vtUZ7DG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B751484A51; Tue, 30 Jun 2026 17:18:00 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF14D84A26
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 17:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEdYvT1089823; Tue, 30 Jun 2026 10:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=L0Am/pK46MwCiZj
 89yhel5cLle1XZ0cOjjlxDHjFpSw=; b=df0+eYA4scFkF4mKEEAQU0+PlU0EM/8
 HDPAGfxEtvrmCs/53waxg1nT3HY2R24StFxLsH6HdMFq2hSoXCnq3UrxHf+zSaGH
 oxSmDl4bZ9Qot8H9lgUnQSmlNfdUiGFPqv8sAmXFsP9jkaYzTl8gtfarHSpzQC8X
 6X7BL7PVQ0/HV2EuHf3AMV6WfMNN9vVF7tko6Jng3nlNsZhFZb9IAWHtRW1n35Bc
 srU4Iv3KbX31vT6c+5zec/Klh0+m8JUhZ3wrCH4+TMYLLDZU7tWo+kMM9RnNnNBE
 6h6Q5jz2/hpuPw0KEWlJoPLZuQZv8ZaahfGmDMt+DnAMAQDTBl6QCbA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f47k7b6ub-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:17:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9ANoOR+yQMXon9VFiZfABSxo4Uc+7fRlJHw9PwObYj8sWpmaCn4/u4bQWtMhDa0uIakx1jdFVnOuFH4LlXAlSNwGMUMYphv0kvD006VpufYGUnTK0Lcc4a5QFmXfH08+t6kftAtZjgE1Z6RyEdqRxA12nAdhZaLyB0Jd9mivnDWNT+p7nv0DU6WOa2KPe/nMWg0TYpabBxxBGmtN3O5XCdDmtdNYoEMB9uwHfOlW+h4KSV9W5bhAYvYn+OnwnGN4+ChdCnZX1PbSOWzZ6GgNbbwBNnGn2ieeIWzbtks6jzWLkhzsItbkWrO+astUEZ+yZ4XGvLlUl1IPPA+8VbvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Am/pK46MwCiZj89yhel5cLle1XZ0cOjjlxDHjFpSw=;
 b=d9DpeIPtcWg/HaADXuw+zKCGAIA6vJs/0Fk8xTZ8izIv1l58NimXlBNYcENiHtUxwKddsEvqKQlGUiVgcWUinvlLXlAZFhXwnLg7H2anCPZ9i6rP76q/ky7Iwtu4ttsmU0VBBQzEuLyluKyXdwgge26Rxmf+UoWZ48RGXYELrKZMktmiaPs9RK9pYaiF2JNaNCxia3x/R6oH6Hym1nQW0lhRus3Dj8FRBYGErjvZsoPiDMC8RI0tSrMSFjSsdfPq244oWAY4zGNp2t/Z2tG7IUpTv9e5kvLqfM6m0el6/YQSKUJjctu72mnI4mixHiBINr1jqNhDIDA0JikIASMTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Am/pK46MwCiZj89yhel5cLle1XZ0cOjjlxDHjFpSw=;
 b=vtUZ7DG0mnSKYarD7V0VFXm4A0Kz0kXWzw8DtKi2MBLU9oKdKfhRxFfyi7dcpKbyKBh+PZPxSaf2fdiKKAYiGvsVbMUZvbRIl27Z3GD5zxFagCM0UrT/nPPHwUNZ0uptG9FHNemGvkffBnznxGgqD+8mt0wyWmyz14nox3sNbRA=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by MN0PR10MB5911.namprd10.prod.outlook.com (2603:10b6:208:3cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:17:47 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::18) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 15:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:17:46 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 10:17:46 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 10:17:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 10:17:45 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UFHk0X2780167;
 Tue, 30 Jun 2026 10:17:46 -0500
Date: Tue, 30 Jun 2026 10:17:46 -0500
From: Bryan Brattlof <bb@ti.com>
To: Randolph Sapp <rs@ti.com>
CC: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 3/4] k3-am62-pocketbeagle2: add support for 1GB variant
Message-ID: <20260630151746.nbrex2msybz5pcwk@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260624211949.327905-1-rs@ti.com>
 <20260624211949.327905-4-rs@ti.com>
 <DJHO54H0KY54.3SIYX4G0BFWCL@ti.com>
 <DJHZGCZ2O03A.5YOY5378VIKG@ti.com>
 <DJLTHZL0ERIG.JV1UL67GFIVJ@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DJLTHZL0ERIG.JV1UL67GFIVJ@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MN0PR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4a3b44-3dad-4cab-3b29-08ded6babdaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: mvp7ya+SfiHdhwfh3S0YUTWO4O1bz9R3OYlhbVE0ewpOX0TTy1jxhKMdzLzOhEC2FXDeS4H7bmbUbO3NnAvBslhSGrhFf3Ai9ARX+Rjo4CTC2gPBw+QOobjCEZhVQD+A9BAgl9chNhuGXQ2tSYzTcxpVX+0IXgm5Tx0nKPrhyEKu/XVraf0eRrgASADnh5d6YO1j8tT+GxzTjxCg4Ld04tRWgMn2v4vGkumguSNXVG8keFpq/TbSyOxhArekPZ1jpQJKOR18WGtEw4/QVL1lPxonD1kGXBgTT1gcTJAI0fENatvRxlpgib2n9esZZnrlBr+fQVmdahEgDJ9gI9nAtjRrcikI9cMq1Cj4KQ5FC42aDBEU3tZ5E0sNjnRV7ZTkzSjQMkVgDX/mcAId0hNezkkE7PPmJEkiBKrQVp2GOFrjMWdK6TcUedQCwvB3lno6WoxQTKa9S+zMYVyPb39tXQM1SjGfNhmhQg+bVDFNomRl6vInyD3sXS/+8+29IVpFHhXos7De4ADcmyqLbxiCJQ3pB7n+7QsAWjY9qevnpAytH0FWAUUjEF5UTlcA34p+yh/qDisQO8kIe6rQNrMBtIq9T+icGotYvg6p6FyLLP0UqpSqx2PMwVv6lHD4Zg09Egd89ZEN31x/wxepF+dy+9uK/0mA73nJQDKy3PLRYcjCw33Oe6rgXsxb9bxjkzmoj/Uu/qyggZ1TGmePwWo53w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yWVrH5NF3iMiCh/Yx4BknzIWP7xPX3EgpEpUfoRu69uScLDQWd61//CVsQHmvUeEwHxDVYKhBKMmFRliWmvIdGGz16Y7HYFKl7AooLm+CSDEmYFrAklxbMZZ2rs1/pOeFxIoTTEU6bcODzKq1QTHG46cu9i26Ngb3WUu3RagM/y9ztt39H8WFDCLMefEiRbxSBYIChWlqTzqZy1eyG+fkFsy71oav0r/6relqMcDyVX9/be2UGN+JvefJBaU0N2lfK/Nr/jkEnzEfNAw8FFxCCPbvMmc8Yp69ek+u/bTPFY787RFxsuarij/NMXVXKO0DN/TL9CRHSQPYQpITxXLXBvKcNXv5pCH6tTDfwuboKtS0xvHc40PJs8dwI18rYIieyfp8xJ1AxIByQOPEUjrP5fxpCD8wKR5hCv2+Vlc8jVVvsgJLDd1FpZrsYs7S2Nk
X-Exchange-RoutingPolicyChecked: Hiwmk3bYL6LJyLHkTkkgTpZTS3DdZbli4NrLzN3LyYBIVYac6o5zJx9zuWJ6x58ND+iU4hcZmEMH1FppQwyNBH8WkW+tT58KocTZ1YHuCc0JFK8C34X4k8bhBFynIcK3dLtZNZgPKqebtgvgMyOAmdC2O6QyYb2WhlruEmh+Xr6UaLiImTVJcz+tyY2KZHPTp6PFH2NAI59oRr1j2GAPSfFQstux5GNBpBdS59tFT/2Vi450Mp6LqEAh4sOt5ybjRdOTehHrR441DMloNTMPAd75Oo2vF0TJvXquSGucN+3wNZPKm+2kjGSB7orI9eQ+NdiRmwPe9nqmlTfLhFn7jg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:17:46.6772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a3b44-3dad-4cab-3b29-08ded6babdaf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5911
X-Proofpoint-GUID: Bf9RO_1ukD8NpT0-KZ4gmzyvQxgebp_r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE0NCBTYWx0ZWRfX20bOE1tUYVD3
 Emtj3JbX6ZwMwtSpeM/ep40ZVw27H3+RQrFksUu4oauzR2X5YE87dCuzdIEpS+3+Rvvts644q6A
 q4SECWwVJbuT6HsPZggLdilJToY/PdsoicboESyWFIv4ECFAqdToq/JYCEtGygV0feGIeinjWXk
 MZPtefaRs5RLCj6hlKOx0viBl9fTdhc35n2xJjds7+Xg1RVBtm6zqxk1qE/LQ/LLD8qefHusxv0
 GYz1nFYKVd31h/7x86jkoCqyfJRVebrxI9GWg/Oo289z8DyPT92lgNSP1sdZz1efrUJkfDqc7Au
 nmk31aHoe1uiYjgt/WT2a7Jj46pyAuyBR9sQUd6Cnb2K5bOEPp49O1e39SLoWqrSgFPmPx7P+Sm
 JPsiTaDdAk+uDBcAYt4yZKUS06Kkljj4lCGA8tqQnG/ATN+hGxx39nbGWyI8/QQqcwcq/FsYmop
 RXGjQpMFQZvln2nLBKA==
X-Authority-Analysis: v=2.4 cv=UshT8ewB c=1 sm=1 tr=0 ts=6a43de1d cx=c_pps
 a=TnfpHwsis7t5HKTWWgh6sw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=lLZmtIKjAAAA:8
 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8 a=Jq258_EWumuNFr1u-LEA:9 a=QEXdDO2ut3YA:10
 a=q5Nj8NTjyn2D8kUwajRn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE0NCBTYWx0ZWRfX8WaO/0qbjUYs
 R1PEXkb+135TekHr46vmpRsWkmwDTVDWqcz65H3gQ2Ej6ZratX7LrvWt5reYH2goPozBE+G4k0Y
 cXgZJUDdOSJNI/O3nY+8KHzq6U1jSxI=
X-Proofpoint-ORIG-GUID: Bf9RO_1ukD8NpT0-KZ4gmzyvQxgebp_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300144
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

On June 29, 2026 thus sayeth Randolph Sapp:
> On Thu Jun 25, 2026 at 3:21 AM CDT, Anshul Dalal wrote:
> > On Thu Jun 25, 2026 at 4:59 AM IST, Randolph Sapp wrote:
> >> On Wed Jun 24, 2026 at 4:19 PM CDT, rs wrote:
> >>> From: Randolph Sapp <rs@ti.com>
> >>>
> >>> Take Phytec's current DDR fixup functions and utilize them to
> >>> dynamically adjust for variants in the pocketbeagle2. There are
> >>> currently 3 skews, two of which are both 512MB with the same memory
> >>> configuration, and one which is 1GB using the same CWL and CL settings
> >>> but a modified density [1].
> >>>
> >>> Based off of Bryan Brattlof's patch [2].
> >>>
> >>> [1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G%20Bits%20DDR4%20SDRAM.pdf
> >>> [2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990d7a33fd001ffb571e13cfc3
> >>>
> >>> Signed-off-by: Randolph Sapp <rs@ti.com>
> >>> ---
> >>>  board/beagle/pocketbeagle2/Kconfig            |  26 +++++
> >>>  board/beagle/pocketbeagle2/Makefile           |   2 +
> >>>  board/beagle/pocketbeagle2/pocketbeagle2.c    | 103 +++++++++++++++++-
> >>>  .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++++++++
> >>>  configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
> >>>  5 files changed, 184 insertions(+), 2 deletions(-)
> >>>  create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
> >>>
> >>> [snip]
> >>
> >> Just thinking out loud here, but maybe we shouldn't take this patch. The
> >> industrial version, on top of having more memory, also has eMMC. That already
> >> mandates a new device tree and configuration if people are going to use it as a
> >> boot method.
> >>
> >> Then again, maybe it's convenient for the users who don't care about eMMC? I
> >> dunno. Seems odd either way.
> >
> > Since it's technically a different board altogether and not just PB2 w/
> > extra DDR. I think it might be better if it had a separate DT and we can
> > decide the correct one based on the EEPROM at runtime using
> > SPL_MULTI_DTB_FIT which would allow us to still have a single defconfig
> > in U-Boot.
> 
> Syncing some internal comments here:
> 
> Zephyr and Jason Kridner apparently agree with me here. They treat the device as
> a separate model: https://github.com/zephyrproject-rtos/zephyr/pull/106680
> 
> To cite Bryan Brattlof:
> 
> 	I don't think the R5 has the space to switch-out the DT like this during
> 	bootup. it would need to be another build
> 
> Sounds like we'll have to upstream a separate dt and defconfig then. I'll play
> around with this a little on my end before submitting another revision. Suppose
> the dt will have to go to the kernel first so it'll be a little bit.

Sorry Randolph, I've been buried in emails. Thanks for syncing the 
threads together.

My only worry here is having different builds for each flavor of the PB2 
will complicate things for people who don't care about the BSP layers. 
If all we're worried about is checking if the MMC is populated and which 
DDR to setup before we hand things over to Linux then in my opinion is 
this approach is better. Linux shouldn't care about these things.

We do have some space we can reclaim in the R5 SPL build but I seriously 
doubt swapping out the DT on the fly like we're suggesting will work for 
the R5 SPL. The only hope we have to unify the bootloaders for all PB2s 
is going to be with this approach.

~Bryan
