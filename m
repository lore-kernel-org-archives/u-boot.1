Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64239CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 09:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DD5980E21;
	Sun, 11 Oct 2026 09:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFHBEjv7imKJ; Sun, 11 Oct 2026 09:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6850B80E95
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791710218;
	b=Qr3EcreUif1iz30zSCBF20bFJAR/1GopCBplV4JrcPlmOwMJttwvkK7Qgn1bMm+iUCqs
	 LyVxG/fsKYSPCrvLIeYHgRm6QcadqpQqHw6jVrBKdR3lxX37IckefUxg7n1a+BF2PFiDQ
	 9pDNXe5oHOeTL2/f5CW8atqz+93wtYXgk20/UktVOIcLscpXVmD2DZVXba7FpmFIvQR+g
	 aYznXA1v6OrGXP3Sung8m7vcQVBhyBk5w4uJSFeaj4iRKWJPVyCmAeqK1WTfsUBjUPYR5
	 chnIsjMqNsuALhAfEMsKxQmi1ujhlu43XVpM+3+bScavTAFTu93Rg5qbk4SkURnQkkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791710218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SSXs04zGtsxtW5+Vl4wBFhE5Mti51ms7ZaaUciiI/ec=;
	b=ic4qECdM02SK834fkFryV5UyRVF9xCCLSHo7PlBtHn8plcseZt7CQNHjeogwQYHdjTyZ
	 YwvKfilJXscCcL5upcuhu7wBl0ek8M8M3jluhcr49DnJYab7xuekb2ySgfhTBiQeDLUiY
	 SqpIE9gx1a8EWrWCwO4V6iI7ZZWB8H7pPKmw8knY+HKJSpb+j4o6kh+9jpZ2C9ShGiN1i
	 5J+YuGDeBuVsp+O7N76xAN3KP/HucAMG+PJeSdx1Yjj/E/g1qv685vPWmQtMB5sRtqz6F
	 fu7ASAr9G/iYonXiOfOz+1XIXxLfB+Y9jG5c3H3oVnJeAb9m2fzmKh0bei1NVkK5o5A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=toradex.com;
	dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=n9B5QvL9;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791710218;
	bh=SSXs04zGtsxtW5+Vl4wBFhE5Mti51ms7ZaaUciiI/ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B/jHWT5izA9wG85cHJy+l/6tNErkiS6yC8HSunubeRPFjE9lalUBCK7BgHwJA23fm
	 niHIhMM+0sILBF+NViVZG/X+GQflPJC0b4xDqKgYZ7nU9XFGrCdxt4LqUWB4UAjPhZ
	 CPzW4Lm7HSMoa2lxg3UxTsJm4H/b0JZZlBqctKoj2wXh/D63zQ5GJWHueTArumLhXJ
	 GJ8nfhtJK+bCjC4QJldqz0urzfB9tng0+0/Drgw6FKn36n9/qnXRpKfYg7GUVZbd1B
	 OwJL3LPlerDMBfBvnDWOK/XUcr58f7e3+V/8CTHcHa6to+jpL5gOKWV/383wGk88Ah
	 f/voL0s7YZo3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6850B80E95;
	Sun, 11 Oct 2026 09:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 043D1380
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E93C680E95
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfxZA6MuQ-RA for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 09:16:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD15A80E21
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=194.104.111.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791710215;
 b=Q+S5GYYG+4Vxy75gT+lsO2NjDAIJ2RE7dvfEeXGB+5LH2427bxRaZXNAOqbSwLDgA/A/
 iVy8kgW1spguZhoZZcFf6mv27oLviqsf49jxFS+faYv/KdAxa4FOeoXMPoRSOFeVM1sLs
 1uTVsEN7uzmmicV9GdhnDWhi5mjtoW/JJNRJDuv15bGd2hghlw++Qs1R/kRmQH/dbG343
 HF33qgdrIbL6pmWc4oE+v3KzRwiucXGbwGQOrolqcZI4gH7xpm9gMQXNU/FZLl2cQT32/
 ou9m6veT6ORz9ccV3osCmg2G1GWCcdWgUAAvYUKHveFN5NQwpvVv6UmEjcAfzXi2EeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791710215;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
 Message-ID:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Type:Content-Disposition:Content-Transfer-Encoding;
 bh=SSXs04zGtsxtW5+Vl4wBFhE5Mti51ms7ZaaUciiI/ec=;
 b=iX+mRZ8bDSgs8lIURnu+fxREzP+YX7ebg67HPM6SNKH0n5O5veApqsd2PrjA1YrFbcLG
 2T566uUkd7OJrv2dG7c7llmkEmzKzrF3sFNJZwM6NGgAzLVlAj2GjmfqoAgSBhTfxGEbG
 Xj+UiPQLXaelIJkKEISmowuZQHBjrSCkdFyswSJwd35R9uFCsQtm9vnp98ULR7szbad/U
 WewDsxwzOq0+NgX9Tit++yt2TK1KqR1URc0TfGmaMa8SWliyUL3fMedh0GYHgigJff70r
 GHbnykoCzpaxajAcD+SgM2us2M56V2fg5zz5QbT5HW0A8Q2dFlof4nfnmA4jl+G9itw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=toradex.com;
 dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=n9B5QvL9; 
 arc=none smtp.remote-ip=194.104.111.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.111.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=n9B5QvL9
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD15A80E21
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1791710211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSXs04zGtsxtW5+Vl4wBFhE5Mti51ms7ZaaUciiI/ec=;
 b=n9B5QvL90FlE28zkGkD4Nf9VJNcq9zznpTEYk/RDZcMWbKK6ZXSmdcF1QAasxZ8PTdV18K
 omWRgjkyhETiHvlGEHCd7R0QRwnU/Ak97DD2DOtOw1Ly6XetpYmSlm+hoC7BOKNirhvVQz
 uvv/i+Wh28UjeBTmbyAcOiI2iCX45Cg=
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11022119.outbound.protection.outlook.com
 [40.107.168.119]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-44-UfAesKOTPjOGtj_VQjKYmw-1; Sun, 11 Oct 2026 09:16:47 +0000
X-MC-Unique: UfAesKOTPjOGtj_VQjKYmw-1
X-Mimecast-MFC-AGG-ID: UfAesKOTPjOGtj_VQjKYmw_1791710207
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB1688.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:65::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.20; Sun, 11 Oct 2026 09:16:45 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 09:16:45 +0000
Date: Sun, 11 Oct 2026 11:16:42 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: emanuele.ghidoli@toradex.com, ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
Subject: Re: [PATCH 1/2] imx9: scmi: Move u-boot early MMU table to top 2MB
 of first 64MB DDR
Message-ID: <astT-nyb5riMAC38@francesco-nb>
References: <20261010075951.3939861-1-ye.li@oss.nxp.com>
In-Reply-To: <20261010075951.3939861-1-ye.li@oss.nxp.com>
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB1688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5108883b-9215-41a9-7e1e-08df27785e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: plg2QBx/HbjDugxiY77rkg1svUMx7a5cgwI7YfCHYrFEBJ2OVSY4RtKu58je2dZrlGy4DOK9g670LuxY1+jMefdU6LGRW8kverxuqmjnyp5znyJD0ZQLf0qkUkdBmpScTev1NE+P6C2h8rwk26grZn5wiwXp1wGrMs+xYkdUakf0TeLZVvTgvwgCZcX0uZ+0H1oicDSZmkVzWopPHXVDj9oYMDqPzjoGyEnPq/CyqM+DvHKJ+IgEfbGswP0bWLQOzNPcAghhiBXgsK2f9A54iIKo9HTBHw2S0u8qyUOlVFrprgAyF0LAxBz+4vmU/KJSnfccm4dHxooyO4Q5PsaVbezpoe0F/Go/gp51UbLJGTecgH6ZoId1JS+VN+y1gkNIu7ocqIVGQFkjk3twFJ/TNyrePv+eMoOXsV8V6CYJO8PTdonjXpV/2hsgja3DQ11P3lA+noWf26SEqEaxL+f/QyyDCUK5THZCEoQ9IeconA/vHJoaFvotu/UTSMi2ZvtVrlr65d4+LHIN8OUDiIpo+REa8fMFFEnlO0IWAS2Ef5zpYnnP9ANWLAthpfIR5F4IDWqDspq4mKfibgV4t3xUrskUwb13QKJuEkit+turo7aZ8fVLrZfovkZVdHh30Xdovm6By4hK5r5eQZQj92LgBV6Ko0fCNb0Uj3mnwjL075I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpmLDHk76malfifFBtpWhhxqKTfAWV5nkhvWDZmc8Vj4YnScqxYjMplUXtCZ?=
 =?us-ascii?Q?63jqeWdIloqvpD0/PlxZE1N/U+yB+6OcTWfxHaaYUmSQZ2x4xQvUiXmd1ySi?=
 =?us-ascii?Q?BGatBIW/mBWSwZvdnxTid2Yq3jnHfWDr1oGf3Q1Q9Z7UAqpL5n/NygrprnvU?=
 =?us-ascii?Q?zuJrodKgR85Heer5uAKh5Ok/mpQU4Ei7O0zcat5W2jxTle+8sH4ax93Ix7hv?=
 =?us-ascii?Q?Ss5zJa93ehNElLiLb7GsUmQL4rekngqJG4IE1YOgG4GvSHRvvF23zJAAwLKR?=
 =?us-ascii?Q?Gmrl92baE6pIrV5QCgHiGUoqqIkUMA8wv9zAMsuMOlhmdQS6GenJwAjXzZmt?=
 =?us-ascii?Q?MhIAO2ei1rdwKGzl3st8PyZcQ4+s4dOdSUYGwRIjq3yq6BqfEiThXzGZed08?=
 =?us-ascii?Q?nQkl8m8RvaLkWxaUw63MC5cvN4DHcOy6GLri5/ymt1KrdUABBQT5Fh9JAc4i?=
 =?us-ascii?Q?OFoxkSSv8n2NNEqtj6mhIZhOFznSa6XaHR3aSOOK0ccgvVNywV8oH4ipXD45?=
 =?us-ascii?Q?gTMVSxduczAdxSwmZwKGtUMsSrtELWJLF+EbnmDne3Ay9diTcc0FYoT7ztR6?=
 =?us-ascii?Q?ckrwwMSSLPdlhQ6/40ftYv7zvns5+zdy5K2IWCS7945ZFT6mqxVv2sSMBiJt?=
 =?us-ascii?Q?NjZMLcz0LWL5dv6fneoM9hiF5mAZfa786tGV4WjRFGGdwn4i8c6MdtC3+y+m?=
 =?us-ascii?Q?3V4oRwDwJ+b+vn7GUmO5lZGTxUPq9SI7/r3L/dxppmCCXo32JYjnnEdxbMi7?=
 =?us-ascii?Q?UHfc/HhemG1oxBm21BhWAojfXnK5aDbQUuVzgLrUhSAtgP8MQ2XxRSWt+tbO?=
 =?us-ascii?Q?O6GRzWOo27YkaKu8jHW5NpcOMv6hCs/QAAjMeE+hwCN2ZVapOIsdnTF9qTKG?=
 =?us-ascii?Q?P7y/pUoJ8/A89gK89PiSHx+g9IJHLEsk3Tjq/fSHG2H8/rxqiLrOogh6RzN8?=
 =?us-ascii?Q?xY+Bs5Y8rT8OmBgCvdnalDh0/pJnOONrcbOO07DnPjl8M1DxnHKvbCJH1hiG?=
 =?us-ascii?Q?70/ax+C/tmfD86lEhYtZL7HHuT5pKlcNLTRYF8OAmcZiQ8UFaBCsLileWTC6?=
 =?us-ascii?Q?Wg1SIdZWVLzoTavDvbeY3+Y8Jc705VUzqE5CTFsv/z++AjbsN5PdvOBOgkAp?=
 =?us-ascii?Q?VU2J3OigZLgOu/fH4XzpVv8jq8nacOQBqBDG0Srx2Jce4lPna1xCqELMajRQ?=
 =?us-ascii?Q?t/puEap4NYmexrbNC4Ym9uiUbebLdHXR2YGTBlDkqri4rpKZ7Jf/OwrEK6av?=
 =?us-ascii?Q?fag5fBqH29XytcZDhGwLhBg5XfpUWBW9e73aZEjxreyxhXug+lfzbGEmFL5m?=
 =?us-ascii?Q?GqSUB3rLsT+zD9qx8+jz15Vi4WjcUsE3n8KlYfGmNbR50aMUBem8cSwOL/ZU?=
 =?us-ascii?Q?Mcz52BkYzVuU1NXjVNlO7HwCEaALgEskbNWPvvy/LHX44YLFWx/5C8bLBjTt?=
 =?us-ascii?Q?22J2riB9ugfgHDg5VyxvTZ8I0LUilRmw/Y52DHXGeMW7XIXmLVK3eT/02pW/?=
 =?us-ascii?Q?bapM4rL3naoQ6mr3Cr+e4+Mmnyb+/7vhZVikOhhVi+mq0v3yBhvqQc4O1eHy?=
 =?us-ascii?Q?dgGkOFIBVgnBMNBZIX4RSTPwewYXFfJJQnpJ00aS1TOuWXB7vLjAd0X8pxIP?=
 =?us-ascii?Q?QJTll7EiEl4hBEx3oEN8jD+//7+snz3YXvCkctW1KKZwUFZw0gcTUj3ilzG+?=
 =?us-ascii?Q?cMyrwxKSdA0mHENTNI+PrualiOko9ZCbI+RC6vKxJZlfytOgUiE00hWXtob+?=
 =?us-ascii?Q?f5y3SsZbp6BFXcVvwDugDTIWspofX3A=3D?=
X-Exchange-RoutingPolicyChecked: Te/+FLIG7S54Ygxz4cn/CyGPx8qsJad/L8Ubv6aK7MEvz9xYHSW4qCEQyiza8jSie/UMRxZ/RHDznhw3onLXFcz3Ze1iyQ0fO5Ny20lUq2Uh9Jxnp6HJ3ian3jYCCZdUBPvhf1irCv4LkbSHgfi43S5a9zzHgkgvWSrLzZcaW0OuSPxS+4eQC9Hnee3ULKuFE6hwNJAysS2XTs+GKFoR+oc9TAeimi2e2bulj/XOshL4nYyULdE5ywRLDLqEBjtFNX8FXFR+zmN7t/7/Ln9HvgG/D5VKP5CAK2BhLJIhqU8cOj0fcMZ8NKUUfcvzSAjPL6NOT8dF9dcvR93Zva0roQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5108883b-9215-41a9-7e1e-08df27785e1e
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 09:16:44.9259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mn0fgzQ72RHYeNoY8a1qhlif3XBTvuadLBZF9P4Ckxg+r7gN2Ecc2LkEJH7C9ALw0zjdGFUQW3ICK4oQe7apHaFc/BbVB7jE9Xpk2WwK2M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1688
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nhTFR2v1Zr6eYeAZXHUEDK-mZeMrk-XeJsH5biLBf8M_1791710207
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Ye,
thanks for the patch, appreciated.


On Sat, Oct 10, 2026 at 03:59:50PM +0800, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> The default u-boot early MMU table address is at CFG_SYS_SDRAM_BASE.
> The same address is used as alias target on Toradex's iMX95 boards in
> RAM-size probe. When a probe address aliases that location, the test
> temporarily overwrites an entry in the active page tables.
>=20
> To avoid such overlap, move u-boot early MMU table to top 2MB of first
> 64MB DDR.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>

Emanuele, can you please review this and the following one?

Francesco

