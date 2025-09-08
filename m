Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FDDCA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 21:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061ED82B20;
	Mon,  8 Sep 2025 23:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="I3FIDg1E";
	dkim=pass (1024-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="YiTkc8Nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1382C83045; Mon,  8 Sep 2025 23:19:05 +0200 (CEST)
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com
 [205.220.161.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FBF82A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 23:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=keysight.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=john.ripple@keysight.com
Received: from pps.filterd (m0187213.ppops.net [127.0.0.1])
 by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588IsAUK005670;
 Mon, 8 Sep 2025 14:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppfeb2020; bh=
 lr/gFEniJimUmUwmwpKmYT64crbydvWdhb4/W1Ad/gA=; b=I3FIDg1E9THvOqj4
 lqAIqaqynxLWP4MZx8C6xXT0XswtLJKmgyCLUOl60Zi+aCz/6uqiOG1d2KMjUnc3
 0Veajfg/Hn0lZtJ9ELRJZJ20C1KDGV5yr8u53DHJu8xOug8ZTCdMyHlXcpXqOfbY
 eIy941ZgTsFo+lXoWfHwWXUxj3fTS/7mx6CvWMPFsq4u7AJnUvdekWkXrazGz5K1
 F9kPDt4UPpMGXOMrjm7r6CwHyjGHry1nFFiadxgk2pc0Dj8ZtfWnG6wcV8aJl5WN
 Rj+Eq4hA2uZKIJ2QL3dx5pg4oiVmsGAkHIoRpl2tQYD/1epMf1N12oUgd18NOkP6
 zm07kA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 490kj34en4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 14:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6ykz0KJeEgKW3RHMBcm/qd68kpWhMMLuRHpi6l/mdRP8TCvYuzpihKsJ1pgP/i77SPNbyzWK7vXiisct1BRUJumgcF7oIqmUdstZHKpn6XooHLKTpl3zq5vrQQ9BwRCz8KO4uSKFaRglH8NIrryNcPB/OEBTKhQSx0oU2dGshrEltP+Kkel5Z8EcyNiDk0zq4jbkpcRnmjGa2m6K4Ft9A9CYahqDVO3fKDj4P0TKkZnMMYQcLFYnAeIHvHCpFY9UE5hxXh8DOrQ7Y+jswZJ4X79xdewlxDA1r23MrQ+67Heybg4KTBKnIB9ZShbrR0IlRzdQI8zUterynFHmTkeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr/gFEniJimUmUwmwpKmYT64crbydvWdhb4/W1Ad/gA=;
 b=J/Tu3MwGcgGV+912MqhrvlTrmQIUbr8F1piVtYnyWWQ/6RJfnEzJ8y0lsPuv7QlScjC6iINA69jLT5UQStPJaXi8X1r+LuPB3emBeZjTDncA7HF2bouawXF4fVNq98OyYfeP6gI3eTjev8p4m2ZbH8jtnR4atrx1G8XTmnzRu5kTixJLy1oPg/g60Gs1q9xWtmbhCJJUWWnVs9WkUQTwtqLBP8oGsLdTSChuHuh8yM5Gavlpp4GbVFUk7H23OaNBJbiMoarhfraiA8TlejHLeSrhe/yORPe0GDnGgBRqiVQmR/sHdqeogmjKdGbQ2chDY/YcQ/OxXMg58UgTOPamkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr/gFEniJimUmUwmwpKmYT64crbydvWdhb4/W1Ad/gA=;
 b=YiTkc8NrVe+jU2e8ifnUGsf6rQnS845AD7rkqgApUBqhRo8k4YsaxjQeg3OhzdrFknRiXJKcrs3AyZjYMdt4iKRt+Kfd+qNwttwjtlp5EIH/hzwqTSANuquwRN4D+Gp4VQ87451WQPj2DYE5HhNmOGZ8IUtsygTR0E5ElerYskw=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by PH7PR17MB5883.namprd17.prod.outlook.com (2603:10b6:510:155::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 21:18:48 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e%5]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 21:18:48 +0000
From: John Ripple <john.ripple@keysight.com>
To: peng.fan@oss.nxp.com
Cc: alexander.sverdlin@siemens.com, andrej.valek@siemens.com,
 festevam@gmail.com, hs@denx.de, john.ripple@keysight.com,
 peng.fan@nxp.com, sbabic@nabladev.com, sr@denx.de, trini@konsulko.com,
 u-boot@lists.denx.de, uboot-imx@nxp.com
Subject: [PATCH v3] imx8: Add ahab_commit command
Date: Mon,  8 Sep 2025 15:18:38 -0600
Message-ID: <20250908211838.3772709-1-john.ripple@keysight.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
References: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:806:24::30) To PH7PR17MB6130.namprd17.prod.outlook.com
 (2603:10b6:510:1f5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR17MB6130:EE_|PH7PR17MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: b4170795-0f52-4f7f-fc6e-08ddef1d4cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vHOunE5+sNoqHEn0Pb/qc/A0pQmY3dxajtA6DeCkMB9GBkS9W6V6ByBGYjkB?=
 =?us-ascii?Q?XiLlf9f3Zk+ySJeWbNLNkMb0HdMVOQ4Grxhl3tApvNROqJRqRuIDSmVw7pty?=
 =?us-ascii?Q?MBvmz81yPiTYggyyA8QJB4Z93agzUXYW7OAgIjZBbANUH2lo4z0n/nKMa4Gf?=
 =?us-ascii?Q?oJp68wZd7wf98qjGv5KduMZQ/uxM7+Ze2nbKJyQUpBAfUSKgrHViBTWRMMle?=
 =?us-ascii?Q?E7o6eqh6m3UmQOiG5ERkT1BFWFFxMmhiq2o7Yc0ZGwbVyM5eUGSKUJWfzkWu?=
 =?us-ascii?Q?YmQf2rTLCFPitC13yVBH1ZRIrdD3UnO3sxq/Q+zUdWm+fToJ7LHtkq5nlrrG?=
 =?us-ascii?Q?v0lrOP8xgcqdqbvZ0erpxQIaSwa7obN+PPfVmEcn2RYD0ZPLx2djaTWWMfDp?=
 =?us-ascii?Q?AmiVMLKj6kl8FzjKiG9O9cvkRVvGHPWGEw6Wala8qvxE1oMr8/VmRT82iLaL?=
 =?us-ascii?Q?q2maMMQ9yh2g5H3Ca4li6p/f04a74dvwe+IRhGosdsQaKYJkx/7ZWciQvPi6?=
 =?us-ascii?Q?/RBKUaQ8d0/fg0AZdEvrHF4tlJTFhF1Cbk1uNDvkL4igyM/QcaefM4duaS5v?=
 =?us-ascii?Q?pc2aUFZgq8kpr+xRRlFPbfB/7PPVZnnlcl0P1rW+Qlatqthgyjq/qWD+0cf/?=
 =?us-ascii?Q?0AxWV5AUa7d13nWWEj5bd6PDTCvrPTaDF5xhEpRA7tm3+DbauWzBG63FQlv1?=
 =?us-ascii?Q?+DBhPB/JuHU4cxYY1MNmVcabR26OPjLtoTZfWab30XjfSL8SXuXp26FKXZpn?=
 =?us-ascii?Q?dW0SoR6Xqvrz1LjamkYqWi/sXksZwSzLBRiKUSPhGALKqD523NBRm7rwZuPr?=
 =?us-ascii?Q?NL9PDlJGjVBUKJ2nZs+H3aC9zHf+ULm2YrT39s+dNOwh1Enx7zmuiXfmKbzZ?=
 =?us-ascii?Q?9yipyyxcZa3DCkE2feM6CWcLCwbSZDHQlbll6p7rKFkUaW5JnZoFEzAmo3tM?=
 =?us-ascii?Q?rXeaYo1vdrIa6fZicFCaRVHe6/GPN/EPFCJgaMXw+yD+eCCq1wHdbW3ewnyY?=
 =?us-ascii?Q?OTau6Qq22N6369FOgyF8FzX7pROGJPjcHUpTNJ5Ab3D1RcB6k/gHa44MzfSr?=
 =?us-ascii?Q?8w/cKdN3TXpRihHaizsG+/ffAj8Z6DdfsoOb2GuccVF5KIqjVjLNy94Q89ZL?=
 =?us-ascii?Q?dLtb1OdBOTgQFEdl3PNvkMecRaXXtDlvE5l/dWUHh8c03esvorFNlNdfoo/p?=
 =?us-ascii?Q?NvWqaWgRaQXkOpJFBwLRvcH/BEepHN4LdddzvtA8nyPoy12SuimWOujKbPFt?=
 =?us-ascii?Q?V7Lk7QrQHpiWswZk7PYTY+LKvmZ0TwT1eygHv2dJLEkiD3qo7pr2elCSWrjW?=
 =?us-ascii?Q?MmE5w9Z2Fe6C65W7B61JP3rd810OG/BOJQdEeX9PmHgZJfjeXbp/h5DFNQaG?=
 =?us-ascii?Q?QOOD7k9L1UxStXG+QsQJYT+mEPefvHhVIhmKT3CTk4rhODBAd6tfmk2F/9pY?=
 =?us-ascii?Q?/U4AwDy8F5w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR17MB6130.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQMGBrK7FKnNAHi9MqygX4Z+rPcEyq3w8kF+Of6vn+HC+GHP7cX5s+osz4FN?=
 =?us-ascii?Q?95Vc3sDomhu9Z++A6g3rEM0iUCtVDHwvmyPGPT7mrXvLgiowNOifa3F5qy/B?=
 =?us-ascii?Q?DbX5935sI9XxaTIy2GqrPtd3docNAvIn2pEtGtGjkd58kU/G4bnBmFyQaPSI?=
 =?us-ascii?Q?f7O4xdUcYtjKeAeHjLW02QRqZ8dIuXqLbiS4gfL5OdMbYBFGkdMI6oigsbAZ?=
 =?us-ascii?Q?ob51UTgnWChdSdw3CpJXGQwFz67kmMiBojtwZICa0QqMBpADO86jRAiqDd6t?=
 =?us-ascii?Q?cFfdtW2/5cB1Lue0Gya5NA9Q66xBuo7dgHi4tf0unW5xtBJfGmxV4MTM3fju?=
 =?us-ascii?Q?7OV9cpnl6IVfywbqC/eLU6v6nJkguJ10bBhYBj+4/LG3lLN/aLkaPhdDTPs3?=
 =?us-ascii?Q?87zCiZ2PL2ot5fo6s+jOqGjEHa9YCiVTjVkEwN5aeArWBqWHUFAJpoMDDS3I?=
 =?us-ascii?Q?hJcxFkwwDYPMDwMKJCrKDUf84nxZlj4xtbXJSZe8JxuaHG9rC/CfPCCGuOLv?=
 =?us-ascii?Q?zquWzJdoAMWJF3CTaCzmSfcQ0jTZMZoJKE7PMw2rMXoOQCVFFLKpIYkNcA1s?=
 =?us-ascii?Q?rbX/B+3TB6ocS86UMDcr0dAMcs7r7t5bpvdSeNJWgtZpH1ycnjbA7TUZgX1j?=
 =?us-ascii?Q?D1iVg9iBP2kqvMhtQoUba+sEnAeXBhsyyR9WScEYuV6ht+XGAhQ9mjbDdWH3?=
 =?us-ascii?Q?1yU6Y0cOnI63UsH5C0PWOItD1su6hNIdtNpvu7ORFg9yJEt8hKywRYHCUquv?=
 =?us-ascii?Q?JbwVqvuC6fRJzAQzPHs/6Avq2NZ2DpeFLeSJto/FT/KhF1bYa7QUTIZqI+Os?=
 =?us-ascii?Q?RhQ6/yNSu8XX1kl1wCwqiGe/JGvwNLVJm5CG4NFU4MmGi1p1ts/6frGzfJZr?=
 =?us-ascii?Q?qu5LPfXM2l0a4IkoNLNMxZlqmWwcCsKlWxpQvENgxp24S0nJZ5duZhu2BMZK?=
 =?us-ascii?Q?Rv2AIj9R2gK8uigs2bF2V/ZbcyxBK2RblxfLYDpXaaQohkF9NCXsb8u3F/+a?=
 =?us-ascii?Q?NXj1F9Eltfm0LxhYF3xbWeZNCTzX28Qp+2qv+hXM1W56Y+JA2dZhSruv6DHF?=
 =?us-ascii?Q?co+XRkAue1K+eT1W0vEYzcgPb6yp+YSDrQMy28UXGsSNIsjxjvcPhHt7DFvg?=
 =?us-ascii?Q?/iUNE9z8jstClR4u9UuLDwLOSNPIeLFdBI7QdO2xmRYBCaMu1OsAxFQLon57?=
 =?us-ascii?Q?HUseFg+DGTj5yJ040MWtHSUKekCc9pgsCi1XxHdCaY2a4LraxcEIbLCvWPHh?=
 =?us-ascii?Q?+vR1g64qPM7lGV27lRy1Dtkh8rzmxIJ+zuB+Bwa7apI8zuYtOUgnjseZxH7H?=
 =?us-ascii?Q?3JlTGs6eDtHFX9kOJsMPrWMtptxTBK2iXraj4eAT8elDv/t/Lp229g5NM8/B?=
 =?us-ascii?Q?tuFYLJFASwcDk5uMLAAklYa2aYwFFUGhyJIPs5BCzAlQAJ1JXGCA9ZNmNn5V?=
 =?us-ascii?Q?iP81+jtjc61yGr20fUdjT1PkO2eO1wSdw7ydX1vULLYi+ayWiPVGFtyvDJid?=
 =?us-ascii?Q?69VE8K41GsOMLB7gmR/Zcf8tayzcOqX0WR7pFXAQcevR6VJ+fqMPfn2ICeIN?=
 =?us-ascii?Q?rhBUpAg7On/DOPk794h/pHnmOmDz3H0oNXn1tg4nwAUxgNbTao4NAKITwN6z?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OqH/heppFTx4Xw03LnQjtTha4rxwSaWF4InSZ3Fls70Q+3mh0GE4NRksrUcC67WIXzTB1xokp2+MZaeYDWlxU8k/IC7Ffpp6iiGorsQUdZYdi6kkSv8L2sPAAuWMLNEMeVWQPiLECl7Q1RN0RDiMaY/65w1zCoA7WvBxIW4wC6VyY1l6IzFVVD9gAYGy2RZ6kDzHvAk98CMJVoIqDoSlnuAGkLx7OD3FT+hfdbrf8MvnO7qbea8SwAFRtwJCiI+zjbvfTGBq28j48hLrBV7Nq9fut9SXNcqHq3Q8swjUHGPPmKVX7UO4DnAfm0zKYzrUEWYcjDx/IdqIAF/vc05bXROBKZHNq+SAKc2GY1BaYShZPLlaywwQFRksZdgwfLgYKvWAt9JBR3om1+IFJnW0iinaM04WFOj2lPDIVMMPIvTNU/+IilxoDg0n0/VR66AB8hl+4A3DG1u/FPUD7gOlvHMRq9bIDN0t8BFzsnS+1DUW9zncTDECeMZUyxBD60jMA5sWDjZDCxP+yFMWcBxdIH3r0E/Q4SlPQ4ISjhwYR1/5w57riUOQB3M9wldNowB2M9Bb0Vq9Qq3CYKs17u6mqNiFfJyCp5sHnlYNx+nB0qd7K7aK1dI+nGMeH0dlpiCD
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4170795-0f52-4f7f-fc6e-08ddef1d4cec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 21:18:48.1839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTwT/BjuAKgaJIXSx1JN7GwsqR209ZOZ6flwYKFXa+/tmoQBfUpfB1Hg2GNQiPLJIsxQwmZJLc3pcqBY1sYQJC4HhyChbzyCcmzIG9GcQ3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB5883
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDEwMyBTYWx0ZWRfX9p4TF1QJxUPm
 GwA5p56xl6hpLooNg1LI/ZZ1If0/eBm8d5l59/zdLz4wMrHpBS8W5A4v1Ex2FmbkwgSMr/SamSV
 Qc+8T5Kn4pY1niVzvP3wA7qZw2pbcYN3aQB4N9MMZk40DCCx7+DFbdPDkyOYSFlg/wQEpvUIzYP
 sQDTAfCrQPiFJ2lBAov9T3c/i6HCRq2LBR6SoNzIz74QbKgAZVLCKoCN3+egTz1sGq8FgPdpVGg
 UQYXIAOIMB+7XbxUWv+gsMeSCh+UO4nZGS4j8TFSk0JJewfgVBdcTyK/X2q69magjCgTX3wQXo8
 D9F1jQ/pXxYfjEv1O6C7k6Kfwarqb0DJcnrV8mUrGykyk5ykNX5ES9yDmhDLjyM5IA/tny3HplI
 4wMheQpF
X-Proofpoint-GUID: PJJEl6Jjy5eOJI95JLq8vkEdHairzrPJ
X-Authority-Analysis: v=2.4 cv=foncZE4f c=1 sm=1 tr=0 ts=68bf483c cx=c_pps
 a=saJovQ9iJe2malDXQQFA0g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=vu2TTH8h0NUA:10 a=F6MVbVVLAAAA:8
 a=DFe7BWdYuPSjU5OGzG8A:9 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-ORIG-GUID: PJJEl6Jjy5eOJI95JLq8vkEdHairzrPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060103
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

The ahab_commit command allows the user to commit into the SECO fuses
that control the SRK key revocation information. This is used to Revoke
compromised SRK keys.

To use ahab_commit, the boot container must be built with an SRK
revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
means setting the 'srk_revoke_mask' option in the config file used to
sign the boot container. The 'ahab_commit 0x10' can then be used to commit
the SRK revocation information into the SECO fuses.

Signed-off-by: John Ripple <john.ripple@keysight.com>
---
Changes in v2:
- Changed patch name to have imx8.

Changes in v3:
- Changed patch name to only have imx8 at the start.
- Add error checking for sc_seco_commit message.
---

 arch/arm/mach-imx/imx8/ahab.c  | 27 +++++++++++++++++++++++++++
 drivers/misc/imx8/scu_api.c    | 30 ++++++++++++++++++++++++++++++
 include/firmware/imx/sci/sci.h |  6 ++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index 324e010bb2c..f9a425c899c 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -401,6 +401,27 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	u32 info;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	info = simple_strtoul(argv[1], NULL, 16);
+	printf("Commit index is 0x%x\n", info);
+
+	if (sc_seco_commit(-1, &info)) {
+		printf("Error in AHAB commit\n");
+		return -EIO;
+	}
+
+	printf("AHAB commit succeeded.\n");
+
+	return CMD_RET_SUCCESS;
+}
+
 U_BOOT_CMD(auth_cntr, CONFIG_SYS_MAXARGS, 1, do_authenticate,
 	   "autenticate OS container via AHAB",
 	   "addr\n"
@@ -416,3 +437,9 @@ U_BOOT_CMD(ahab_close, CONFIG_SYS_MAXARGS, 1, do_ahab_close,
 	   "Change AHAB lifecycle to OEM closed",
 	   ""
 );
+
+U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
+	   "commit into the fuses any new SRK revocation information that have been found\n"
+	   "into the NXP (SECO FW) and OEM containers. For SRK revocation use 0x10 for the value.",
+	   ""
+);
diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
index 8985ab6584d..0337525774e 100644
--- a/drivers/misc/imx8/scu_api.c
+++ b/drivers/misc/imx8/scu_api.c
@@ -1286,3 +1286,33 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data)
 
 	return ret;
 }
+
+int sc_seco_commit(sc_ipc_t ipc, u32 *info)
+{
+	struct udevice *dev = gd->arch.scu_dev;
+	struct sc_rpc_msg_s msg;
+	int size = sizeof(struct sc_rpc_msg_s);
+	int ret;
+
+	/* Fill in header */
+	RPC_VER(&msg) = SC_RPC_VERSION;
+	RPC_SIZE(&msg) = 2U;
+	RPC_SVC(&msg) = (u8)SC_RPC_SVC_SECO;
+	RPC_FUNC(&msg) = (u8)SECO_FUNC_COMMIT;
+
+	/* Fill in send message */
+	RPC_U32(&msg, 0U) = *info;
+
+	/* Call RPC */
+	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
+
+	/* Copy out result */
+	ret = (int)RPC_R8(&msg);
+
+	/* Copy out receive message */
+	if (!ret)
+		*info = RPC_U32(&msg, 0U);
+
+	/* Return result */
+	return ret;
+}
diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
index 588f3671103..876d52cac35 100644
--- a/include/firmware/imx/sci/sci.h
+++ b/include/firmware/imx/sci/sci.h
@@ -144,6 +144,7 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data);
 int sc_seco_secvio_config(sc_ipc_t ipc, u8 id, u8 access,
 			  u32 *data0, u32 *data1, u32 *data2, u32 *data3,
 			  u32 *data4, u8 size);
+int sc_seco_commit(sc_ipc_t ipc, u32 *info);
 #else
 /* PM API*/
 static inline int sc_pm_set_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
@@ -383,6 +384,11 @@ static inline int sc_seco_secvio_config(sc_ipc_t ipc, u8 id, u8 access, u32 *dat
 	return -EOPNOTSUPP;
 }
 
+static inline int sc_seco_commit(sc_ipc_t ipc, u32 *info)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void sc_pm_reboot(sc_ipc_t ipc, sc_pm_reset_type_t type)
 {
 }
base-commit: 7a4f3c5652157cbb3d26a7728bfe537ea483efc9
branch: master
