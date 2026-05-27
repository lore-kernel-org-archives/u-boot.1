Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D1CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 19:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF4C847C4;
	Wed, 27 May 2026 21:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="OIokUCpN";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="iEawYw0v";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="LzbXN1yv";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="T1z084Tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925858485F; Wed, 27 May 2026 21:57:07 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E28846D1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RIwH9g537479
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=5kozN35T7lKXKDIzRjmu9yv/Amh
 ZnX1FVTn1F7CISWY=; b=OIokUCpNlyNHF9DZMHi8z9NCxMqgKTATj5uMAE91k2d
 zGWjCLSSsex62sTra1UYhMIJz0p3xvlS0pSTIsiZgQXDn2yjjX/jYv71M9PFYtTJ
 uBfG1KnoHTVnQDfz5PdJoX7g8oPf0omwJehD7th/Dv1mBgSvWW5LcIFFWKYLJmp3
 8Y1VkkPgXcnlY9ZcaYVZlptWV5oJN2z4hj2WjiMEVXF/ioyeOfeN7Mp/oDWTFLVm
 yO4w0ijzjxux0gpShCaCgBNQK9yf6wTlFPaVbANfiuO0j/DcCy+Kz2aBbUAu0i/c
 aqeJUgyOrAnJTIbfT/x8MuCcqadw3ACEtUGo5ZDZQgQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ee6c08k8e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:57:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unGbEIUdNFYC3nVttJgCGg0qTfDcb7WHb+xHeuLZaRovg/QIoR+ei2HDExzNOyPL6OrlF5K3+RfakTbqGnXYTCl5qt5S3T6nsucvz0TxFPoO6PMIeqJorUeQ6WJ0AJQ2UcIZMZ1pl1Z3zhLBdVdZq27RpF1u/fvYCXCLhEe1OeFsFlBMDOEx/ymLUiLJZwhrHTmXOL0PMb75S1hwkF4G02bqsKJ+nAouAaS6NF8ti9EyOALlsnSiHjofJoNMSOzFFCCbW3UH6O4cYXvSguxUs9FDR0hcTN//OMgPWJD8nI9IDNZH0kNqaX3x2YjcFHoTsA2CCu5+ill+ogUol7EW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kozN35T7lKXKDIzRjmu9yv/AmhZnX1FVTn1F7CISWY=;
 b=Mi34WmnG6Wk0H+XW/H4feaPil7BsfeHy8IBvC8IO3s+P4BavD7jo+AuEtR88p/oCn18oaL3ltgjb27S5Cy9PHD8B6orfC5d+6z2TSh7+1L8KHf1ijunSM87XLl/9dt/9j7sZO1mrrh4fgXDQsBKP4mC3uTiK5tY3ei5txVVCSKWHF1JROJ28dQLbDDhjBqxJC/1Bd1OlzODNWeB9VnKdiFmPUZavOusm0yybedyknPEqy9b6Co5qX8Aj86Oo3r4IbS0lN2VK3eSoUQSnuNu2ABsQLu7wakO5NEYv7iWZa4kSC1tN7s4LKuwihQRlTaB9vuY/XIwhTzHSACQrQZwA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kozN35T7lKXKDIzRjmu9yv/AmhZnX1FVTn1F7CISWY=;
 b=iEawYw0vOSwRdp9bAVnli10gj/11AZlwHX6woCaQn0mwHw/knY20CO1t+G7it3DLnIoyGLQeCrDk6og6fuVQZIG4VAXej2WOu3bqZkemdyvDrUfXDZYUgr5+i4Ui3gcE0KQ4z5kG6sFGDmRWT0YAegaqYd1qURryUfQhV9aKifo=
Received: from PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::11)
 by LV8PR16MB6589.namprd16.prod.outlook.com (2603:10b6:408:263::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 19:56:57 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::55) by PH5P222CA0010.outlook.office365.com
 (2603:10b6:510:34b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 19:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.0 via
 Frontend Transport; Wed, 27 May 2026 19:56:54 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RH2Vuf658761
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=5kozN35T7lKXKDIzRjmu9yv/AmhZnX1FVTn1F7CISWY=; b=LzbXN1yvx/J3
 UduSQREVCgoK2FO1vdMgm9Jj+YGnuU7ISy99AYpjTgEYNI52GMn4mAkTjXt2XbkF
 fRcK/biaonVnnjuvOuDRgMT4lbtdJlCxN6IeChagIafXMwwLWQFqIPRr0WzO/T04
 X14GieuflXRQ7ZBPAAssV4buhrsoQfll2vWN3gbWUeuUIQ2T8QFsGXBcTPD/LqcV
 fLNUZGkozxUpA4neDI68WJzyadjSB1u/2ioHAuJgrqJwJPNiLO/wTIn6WjrmZ06K
 8GiOaqb8rAaF0JWGbhI6gojc3WRoN/BEailJcUMUzOmTbvrGLInPfBoxQg4C7aZD
 +oqliK3rbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=5kozN35T7lKXKDIzRjmu
 9yv/AmhZnX1FVTn1F7CISWY=; b=T1z084TvW2liXOnLkPlWMkXRVeqK2EqDQeTg
 UGZlgURmB4DxGGdB4DTN+QGArC7VST/QIrfytakGJushDCYnN5JTyoMCk6Z5wS2v
 sDU7FfAiVW7qb4BREWEmmANUOFi042CGZlDTINkxP4oEy+V86NhrvOBSGi0MLC0o
 Jm9B74xtMxU9ms+5vHRRuwavxU38V8OepafamBNYnjdnw7DX/42vPuzlTH0ipJEc
 2foMWYkx9e11eiEin1+wMBzQordPKkQn517pSqahMA0rOt8Xknuow3SmSxzlAmBR
 rlmu363d0RhuLKcMFzc2CMracOJQp0oCFekbfZGMwCP0wg0jDw==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ebx4s4n2k-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:56:53 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SKN1wRUcJ9jbESKN2wxjJb; Wed, 27 May 2026 19:56:53 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SKN1wRUcJ9jbESKN2wxjJb
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Wed, 27 May 2026 12:56:51 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v1 1/4] reset: Allow per-board reset type
Message-ID: <ahdMg5oAFcD/zaZ0@kraken>
References: <20260522012312.860026-1-dmukhin@ford.com>
 <20260522012312.860026-2-dmukhin@ford.com>
 <CAFLszThsj6qU6t=D9vecX=2doi17g2CzPwBK1+-pjaEmezVykg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThsj6qU6t=D9vecX=2doi17g2CzPwBK1+-pjaEmezVykg@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605270199
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|LV8PR16MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: fc082b8e-419b-4b90-0f20-08debc2a1a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|4143699003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: kcclWnA1LXf2o73wZjEXDiZa4gUMbzqtvBajvD/csanwlILmafTu1GuetxmMqnDkxOXmA8KeyJxoZ8e6Vf9uEzj7Gsz4so/QHqg1cD00YtSYZg6KnpRjC+V7nHZW1tex+AfczBlwxYrtoK7qfBWXMSOLjslT1eF/6LGQSLYAtSQ5R8jlWP+JuGf6q/ABjSItyOy5oijYu/jo0WW1vTSfG0JtsPlgJQ5nP29HXganrQ/3RobPqTk0rXyqsrR/U0gTCtRZZRMvw3qHM2M5+jfdC23UlROjue0iS0QdWBsFBHhcXN2NizLoNUWy83OQwoZ8HMBJzDcthqrpVWi+PCMewZLJRJGbTJGx5klzn7FzK2xioNjL8OeC8xKpCpilssemDM9NkWzNdpu/UlP6/KIWcsynukFSXRB5SQS7bSQ0YfzyarztLDQi0YtV50B1cOHJLSqxV6MnLyipGCmnYtgkS+Bl2ALKPa1zBTqEuvks9D+2NXuAeFGApJ3dSIYiYNxSO9Xjz2CRdQZeXiMW9szI6Kp7Skd/VcE7CWbMX0Dlu8Aqg7bnzFpmXZIiwrrSZs99KY5U3OKjvRtIh/Ya25i6+PUYcXOxh59FhF3ahSxBen2Vt7Su+sBJCzItAgRow2NGnj1SHI0PBIgblgqLEMPXKrgXgbpCPW77V8/wIszZETcSRCboR87RCud5VgYbDxwaGPVtl/HQoX8Igoteo5UKiwOfrDooGUEd0D39K5mnzyg=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rC1YopMEXKvApuKd4fjPwj78XBhLaJOzrguftZHJBQlya/fHc3H7NL9CaL8knoe8uaXu1vNwK7EXl3fFj+3iyrp4XGqq5nRE28+gWK9zGV7ffrS+uUQ/tS/b7qVzVdN1FpCQo0u9+tRHjjfdCsH28Sk+Jo6dO5uM0f08MUCNBoLtxgyFszY9///puHhedorOoSAw/lRQzTT9sdqrAHC/UfVKaXW3LIz9+BL0/ShSE5CCDnjPHySUvPHcdLLz4TBojfVzkpLCBXlmI7IGIqTA5H+3hbGxOom/jh6sp2qJOg0jz4r91r7GRIWrEEEEX6nVrXvRi9/fXa2etsRv/rrdXeQmj2Ir1ZPA1D3rmp4QvFf5Q/o9YzmhEDXlqfjhuypBVUPmy6dM00ZJSIHSaYlXlMrH0gtAUEEAiYi0S823QrJbLRC7UiyPFpHVueqoEnr2
X-Exchange-RoutingPolicyChecked: Ts17Gr60snnczOOKWovwTU1e9kouGiYQ1dMqItJOKzs4WPf0p4yPpVfsF1m7cfSF/8jDjMqYzCpwMMOXYiWn1BDahAPokbBPv1CZTtvX222BZF5t7dunqP6y1oAiZ/N8t6xlgAh1Fc4aXKPC4nU6PvgXSTUYq1/npqhuQtoEAZ6UtpTsWCuaju4pMn3HOqdgbnIIAgvJ+eDJPhsHJyU020D0VsPCm0ma+xcQ8xFilUUz/Vu4Xq4esDfy3Z1Mu5vNOdrYKm1q3XyC0J/SyVtHH4irs6Q9614u2SsBO4oPx4TZbixmZNU0cjcYK9ySlnRS3VGpWsH0oDZH4bDyalvSkg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dyjWjDTF0SWjNLxe22aHbKD3z0UNLB9q3tBfxD1dvf266S/RHZroNyC8ZaGNcf5U/PV2VcIqE+C5n87fKvGZ/x8eHNmOzIPUKf53OX+04A+7K4Ytl0B8B3d3n4vM2s1X6BWnYyFnTG6tvuyT/k4Cv8efyt8JdaVbI45kvycxnb0aMV++thfy2gjldNYDIw3BgLI46BpJaygzPVNq0DWpHVTPUbfleeZWi+HBZWku10z5K4b5hMRFPLcNZm0OlXdjSUkzhUhp/VQ2s/feNesD17PahQ/GB+N3d2INk0nLcWh7xo3ab1C7XMCtJ+VEIf7UZ/kqBtTs8+6xARxkSH3gq+85S6760euZRn1cIcIOleeJrzbG4uPMzPQfR1D15ZsK3fjoxlO2Uu3UYgVWPvjuw/D6MSOZJdbN7lW779967ihJ4YGqlly74uxTKpBbj4bXyE/wiiBTKh3/3bzh8FKkrjru85+88QCJuLrIyc4WRtg9KH2/eSkEtaK6fV8q5sBkFiqw7rMxC8CQEwcwXDujdwaJw7829/6egJpj4PTRUgi+kgNIqCHaXnv+fSCXy6369OeWTvUG8o39QCUO7VXpMqdtLsYt7zCiLQpPUXHB9OUb9umIIZienZO+Xm5KooQH06f9U/GA/c4l6T5mNaIKEA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:56:54.7494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc082b8e-419b-4b90-0f20-08debc2a1a57
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6589
X-Authority-Analysis: v=2.4 cv=S8LpBosP c=1 sm=1 tr=0 ts=6a174c8c cx=c_pps
 a=y599upwrfiZ3HV94zaFOUg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22
 a=cbNQJ9GKAAAA:8 a=PLLH-8EdLVjUiwY-WkgA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-GUID: qxpoTDAP38xhA17ZQKermYeGpoR9T8Pq
X-Proofpoint-ORIG-GUID: qxpoTDAP38xhA17ZQKermYeGpoR9T8Pq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE5OSBTYWx0ZWRfXx40IfuQGU+I+
 nk7ZYSM6KPHVtkUOPYcHT/4vT/f2eFQUCj4/5n63d4J85qA2BB9mXJif+y8P2vX426ABaLCOEXy
 +oGhsoNrFeNFRHVmbUVKGo2i1xGbRPBcWv6cNLNFIXmF8DAVq76HcpUBF6ItTMmVv8k+VPU6Rj3
 UIf+wvToaKUImnYQHfPhFaOVg1bZ8GAnsBm9M0r+isLjNFd1P3I2wFGzUCS0DOr7alWx9KcC//F
 PJ64UzlbeyyqWSYu4HHfJqbH01QkaoNoMMM8EK9rQx0ZWCRVhoqJB0lw4IQ9356ycY07Dh2xTHz
 bsZQkr9r2Rwbhrw2nXDtM7h1MEXnTA/0kulihUeGszk3h0wDCTK/5dGiS/LvvieuRuyL/hzpnor
 Krmd7rl4d310QqlgS2TyqValVs/7OalfELA+JiwXKSwALuTDvYNf8jHFe0KO44Hl3YkcdN2CfrP
 jbjt5YsdsOSvfHjcIcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270199
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

Hi Simon,

Thanks for reviews!

On Mon, May 25, 2026 at 09:28:30AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:
> > reset: Allow per-board reset type
> >
> > Some prototype boards may not have (temporarily) all required reset
> > types supported (e.g. only warm reset supported).
> >
> > Add board_sysreset_default() to obtain board-specific default reset
> > type to enable reset command on such boards.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > drivers/sysreset/sysreset-uclass.c | 7 ++++++-
> >  include/sysreset.h                 | 7 +++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > @@ -150,9 +150,14 @@ void reset_cpu(void)
> >  }
> >
> >  #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
> > +__weak enum sysreset_t board_sysreset_default(void)
> > +{
> > +     return SYSRESET_COLD;
> > +}
> > +
> 
> I'm not convinced a weak board hook is right here. Since the value is
> a compile-time constant per board, a Kconfig choice
> (SYSRESET_CMD_DEFAULT_COLD / _WARM) would be cleaner: no per-board C,
> visible from defconfig, and no new ABI for the sake of prototypes.
> What do you think?

TBH, I did weak symbol only to minimize the diff: this way the change
is isolated to sysreset-uclass.c.

I agree, Kconfig is a cleaner way, will fix that in v2.

> 
> The cover letter says cold reset must still be enabled for the
> production variant. If the board gets proper cold-reset support before
> shipping, the override really only wants to live in the prototype's
> board code - a Kconfig option makes that lifecycle obvious.
> 
> We could perhaps go in a different direction and use a sysinfo driver
> to specify the default, but that seems like overkill.
> 
> Regards,
> Simon

Thanks,
Denis
