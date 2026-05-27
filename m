Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB01CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22188489D;
	Thu, 28 May 2026 01:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="fR3tPMJw";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="L6RR5Qle";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="JDBzCEJg";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="XBpyT7qT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1814848C0; Thu, 28 May 2026 01:13:27 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD39846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjRw0823194
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=K3D
 pLNHTi+96KbPpQ128MtQidMAdNZPvoT5tbbn5kos=; b=fR3tPMJw9mw1ZTqNfcS
 nfC5oc/Gn4A5aZeHcZ1z6Cvte87tGjQC7cYmxLZvALD3xJdWhRQPJuUFt+uaJ6jY
 5gNsHvxLsQ3tbhid6/Ghbj82o5IsRZmyBVbBS1BNU1vUUBje9IiEkmuChgm6R0IP
 h1myoxtVfuOh609KrS6b9n3FnzUFcGrUd08aVXGTHMD8HtUE372QOerj78c7Y9Sr
 tcft5Uiic1gyx1P7KHMcxLBZndEthwYw33uwjwUEq27kChto3+NwU60L1fyaqSRr
 YG2jNSvr6qSXoELgnOchZvZV/ENK/r0U+h/+T664FGalJ6blcuIIws19aer/KfiH
 ujg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7x48sfu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/Yyi/+o/1xDSU0G8nTjgF/jVxMCVVSUQijEf4uU7zfCRobowRXjRjy+D3SEaJVY20yv9o5+QxovBvQDZcA1K3X7+vkS1iQOwCZ0ugdLJ2UY5bebbTY+loBqIV9oSJPEGP6nTtQP8zDAxEBzT0uu9xz2Z7e3ACJ+QXMEmbCyiFrxKPQy174phw5ZYfFNu/dM75+gku9XgHthSfgEEpg1NM+cPzSh7F3OAy9NjO8yJV+gD+XQ8fjRlmlZ5DlhIWh4XiqmlI2BQwXuyJ+F+sCM+RhD2qgPC27szwlHFbFvBzD2xqCkcFjApSY9K6XiPn1PMPzdCppGmd+XIoQ4gu4iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3DpLNHTi+96KbPpQ128MtQidMAdNZPvoT5tbbn5kos=;
 b=WnDjCCAmrbm70aGXtt4NCdG1iJ/CueFwccsAEouj5LzvigKOxVBKapYJZy+OJCLcS14VBxc4M+stgqrrJPQoZNBb3bpDlJaZOyGeiyH1yZbre32R9KGvxS4vwTs+H5VYFOGpw6qD7OwlthR0ErJmEsCdqsgxNwNjL2UJO8tNlcYstyD0zxuqEEiiCfqhYbvvA/5maz+5vnCoFyokKgIssh/h+H1wNI1edTKQ1Vze98ZVNMsHgmI77gHvCMeET4uRf+fOko7Ss1x1njYfQ2dH4Xa7R5oHhFYWeN6NIbRyG8t4OzPBGjc9UrXzzxPU9fRYftUR0YDGQLF6363C1noKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3DpLNHTi+96KbPpQ128MtQidMAdNZPvoT5tbbn5kos=;
 b=L6RR5QleK1CCBHREpnP9gkWP4Ccb+h39Z1kS6bcORB2nq77is/8r4T43vU3EQkZFqMtiAARhcz0fmFsRbfdD8/xppl7apunfCuaOv5bVts6gN0vXxkYA+wgkCXjCBbSBYq33wS0mxPnUEjVlwiUUm6aNDAim6G++qlZVzAzCXyw=
Received: from PH0PR07CA0075.namprd07.prod.outlook.com (2603:10b6:510:f::20)
 by LV8PR16MB6397.namprd16.prod.outlook.com (2603:10b6:408:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 23:13:16 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::e) by PH0PR07CA0075.outlook.office365.com
 (2603:10b6:510:f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 23:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:15 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjE8w2743679
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=K3DpLNHTi+96KbPpQ128MtQidMAdNZPvoT5tbbn5kos=; b=
 JDBzCEJgO9ePx+AJd1KE/0IQwyFHlQYNCydX6ttfWT9cgtmQMW3FJU75Yzakrock
 J08vDLtpyT1cGy/Esi9CaYPcRQy2lMpiNNW6nq8tdddDbuj6L/8NY8HVrogjgGM5
 Kgb+IrWfoYbcqUgRZUtt78vTAZa3FG2U9BmLnK9gaSqj1aK6JV4G0zziU5vp58+J
 tmWC7+7ICgFbAXL0Hu7eeXa8eQyYc7jKVKnAusxf8zbXIUuScfTes0YJZTu+TRfJ
 kLcjY+ujADl4jHjm/uvXg9ktXvqheZq7M5Uf95ysOLZ4PUusGZ5hERGBawWyP0uU
 gb+3ALPfG138L76/TaAyZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=K3DpLNH
 Ti+96KbPpQ128MtQidMAdNZPvoT5tbbn5kos=; b=XBpyT7qTn4rlLhAJ82hPvzc
 ODaB+JIwo5Tzehx9Cjx96lY8RKXUvqw+/wQjiyyT0mhZuzVDG7kl0Yp3Yl51VBJ2
 kEzr3yDAy5K/k2ymROJEDXlAOcSLm+9vuiPFS6W3MLfl4DRJFir93iHDfvPSwJ3P
 tw4RYclY7ySf2JsoqO517ql7FnI9TDHsMogwm5Sq8vQACrW6ddQo0vzT2qvTqMpt
 IZyUxmMdJ2c5fY73a4ykctD2vGzXMgFDurgsE85VgC8+pfTarQusBpLlyoR8zdFV
 VlPVbn+HoGuf9t4YrMdcBKxxdkXkhyh/TWfpSdv9NGBIX7UxCYNWWlhkeOst3eg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5r3yp-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:13 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id SNR1wSXphdhUUSNR2wvGC1; Wed, 27 May 2026 23:13:13 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNR1wSXphdhUUSNR2wvGC1
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 1/6] reset: Allow per-board reset type
Date: Wed, 27 May 2026 16:13:01 -0700
Message-ID: <20260527231306.1714741-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527231306.1714741-1-dmukhin@ford.com>
References: <20260527231306.1714741-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV8PR16MB6397:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d0d3a493-0f32-4f3e-3d08-08debc45882b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ozNclRqWTP6dVmZPjFS69+c3bQjTipJ/Of4b3pjOhnPmKihb5YfMyGyvaLxThjrd//N8EWN8lVJz546qRDc+iD2aU7qdOuG+S2Zj14DqXhzfwpgh7Aa6YKVnZAMTwUEeL5z2m4fGeOu+In1Ft94fvXan85koLxUdn6UZfZUkFSOGutCraNQRSU6fKyo8hP+/sdt8O+X8ZgpgWd7VWGTyoBCNIrJqz5p24/HWyjN6mlk0fQMuYOaxcZkZmuowwo5ZUvOcB5v4hTfQGgVa+dom/8aSt+Y53aQdIPaQaWHTqjkD9pIHQPvd4r+6nWcvTDlrKlqw9Xw++TYlNHc6YOsLW09nb6+jHhTugCzErmA4aolbC4t8ZAV2pzqURCssIolq0sEshmjcXBu7TINCXdE4KhJ8BBrbXkjRGM3C3LarlqMyC9FY+AE71r6tcnm/fUs/oKWvRJhYvE6JDzaJ/wlY+KB7Wm9Emw3S38vQeZ80APiaj1LnFe3rCj5jF4wVwKVONSyK31x7JWgLobNOyOwi7taVVEXqVbTigjsU8rqy8KBLjQ8Ao5ahMqjPjj6ptiqCwJvTCVNQMOVUdSyI66khlOn3gaxcFt3mS7DmSkZO7mjqunxVKNqQNncwmrzo2w4BfgyQ2548uQj2MLY5vDCO0Ea1exLRu28kgjcQXwwr7o4YoyI8vfKHzSStwkHhr4RRPhl8zutrjqSVodJHIA5s7HlzBF3wHcIJQjPzfRlNBfo=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0qEVc0O46wLlBsiN07DMeKUaS4jssXTz2DpkQfGbNARSaGtodZM8tddVEofeUtgh+6gwsOlXGQQlEvjO9LvmCO15zBsSJrFms3FDbHr9tQU0dTNIaPWaWsDRxlqeWN9scSxFIIkACCH4o8xAfTAdJyzTpfr7fmI+/pKzwTdmeDO6c9KRyogxbl2NbaP4g8qbecuIrwtnKS2yIf9COCGhS2HxCnHxTY8s84Qay5dlksmGu90a/NpDmQ/xGYxSA5gnqeqpplYrcoZlBNOEec3APGXqMrCRdqI74u0i/JIBTSaGGF4Anb8U+FglTU4K3Qq8Y0zX47659q56l28n22W29xZyGyR0bagQwVhzSHTT7deJmBk9f2mkcmznKvaSrHpSPlwfA9K6FLWHXGWC5oG4ad1VqTJ4uWKUDd2cv/TrcBJotxITOGoTbNxY53wfYQRs
X-Exchange-RoutingPolicyChecked: raVA4oq1qXfMUJ1inHDHBhYKrSRjk9dS2z8p+LRspOqaw+HQG1n/SMJRjwY+1tMTyoTzHPDhX+OJcJJjtufEI2BepGoAnf7qz/GAnBPsnkGuqY4etY1ZUJk9Kj4J3Fqn1PeUWz0V6dzEFgBPxz37RjFaN+Lhu+lJPyjOfprE/Cksi2CWdJdNfowxW2n3MEv5pLpUKOKU/kQWnP+LkXUB71Me6Fe4WxxwgTyhXWHUGUrOFFLupfdmzdLJiI+sVvb4wm4R55xM416E4c8mi42x4mfr8ZM8ln2foLWmXvXGzhFBxEif/X7l/KdzS0IHdL6+667L1tAv7SumxD1OxnEsOA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 83Ab/HOiwP3sWjhhJbJRRd+10kPaOcJLBArwKzuzredoVdgWF8fJxXWkCAim3V66PYo+HMkILVgNDJ5uDtNzqN0+7kAyV1Q2i27cjZlzrrAM650hWXdfyRKK/olMNlVLf1OXLrSjIEYYh/eLdUoT/0D88d24aTU7HhGWx1ZIC0LjqxEO2laOGubn1/T8b4CKZbwkxObYz/DMLv+AvNf4lVCbC7UVTGOvkS2Tf74b4osAi9Uu6aXlqvb92jKJpYrQejAtS9KzTSp4fnlK8ElEiRmgzh3GroKJIludV179lBO+cFZ6sZViMuEmqSngJmfp9qyIFLxLG9yA8+GQCGQcLYO7gD60w2/ukOySwrxwjXRB0UdDI2UEk4KM509scXxQDSTuwXQNxelEWPdSfjw7vrcPu8x/1DL+qUQWwCqzocdcWpZgAUTkOlkwICHRr6dgdpxtWDA8RZNNOINUa4YdInuqquohG5LspwYNp666Xoi7/ocFJxCHaYxK2g3bj25cLnLTC/N904FWFUddaKJzlRMb/OvGESqWLN6OwyKg2vaAxlqyy2Pb8KxRnNyJOSPMYYP/l4f+r3fug59kTlPFCVOTDW2v4xe3PIibM/o6/uigWwH5enonDzQ4lp9ljmNNtIuX5G2giwyizMgDklL4Rw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:15.4801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d3a493-0f32-4f3e-3d08-08debc45882b
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6397
X-Authority-Analysis: v=2.4 cv=eecNubEH c=1 sm=1 tr=0 ts=6a177a8f cx=c_pps
 a=xAd66yR1laZozgwquCAwlw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=cbNQJ9GKAAAA:8
 a=ejiq-ewEror-4W4SFSIA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: y2Rk2og5Y7LciBoL8wfAXJ2DGMRME6ot
X-Proofpoint-ORIG-GUID: y2Rk2og5Y7LciBoL8wfAXJ2DGMRME6ot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfXzhSlqdzQ0ORa
 ccjudrSMQUSO6VH4v4KSDbSt1HHPmCzzbLFoRDeB8gQKMCPAaxrubuute+se6p2M5e2rn1w1/kf
 Vad24SR/Gawv3fSZdYjhE0IjtIAGZeF2Vaw2x4mcgsu9XyHh8q/G3LLLFKOSKQEHe9dRZ2viDyj
 FV4D8P5DplBNc9iwBVLop+fILr0mFWdfFcw6ueO05zlmn2P9J1xe8UfGgA2lh/CNJSyvMpm9Vq6
 YFKYVa7yDVqWcIz9jvb3Uxprlsae3UJJrGq2fnQC7FgLzlgmrDe38lp+uRuEmXtX57O/SHp9yXd
 0YNVCm3ZxzXsmC6GxCqsx8YT9GvDSTiPmBLtpku4RNpBkg8F5AE+TF1hbGZFRZPklAMdktoH+q6
 b9HznpBOrA0hq3aapawVjgL5QPZMiwal9gioDGCMjo3Zk5kjrsShUgbTN6yzrsCZB+WLa+8JV39
 EPHw9y1j3MNG+uM7F0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270232
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

From: Denis Mukhin <dmukhin@ford.com> 

Some prototype boards may not have (temporarily) all required reset
types supported (e.g. only warm reset supported).

Add a Kconfig choice to select the board-specific default reset type
used by the `reset` command, allowing it to work on such boards.

Keep cold reset as the default.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- reworked to Kconfig choice
---
 drivers/sysreset/Kconfig           | 31 ++++++++++++++++++++++++++++++
 drivers/sysreset/sysreset-uclass.c | 19 +++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 90f740f51d42..2584c2b203e5 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -57,6 +57,37 @@ config SYSRESET_CMD_RESET_ARGS
 	  additional arguments for implementing arch/board specific
 	  functionality.
 
+if SYSRESET_CMD_RESET
+choice
+	prompt "Default reset type for reset command"
+	default SYSRESET_CMD_RESET_DEFAULT_COLD
+	help
+	  Select the default reset type used by the reset command when no
+	  explicit reset type is requested.
+
+config SYSRESET_CMD_RESET_DEFAULT_WARM
+	bool "Warm reset"
+	help
+	  Reset CPU while keeping GPIOs active.
+
+config SYSRESET_CMD_RESET_DEFAULT_COLD
+	bool "Cold reset"
+	help
+	  Reset CPU and GPIOs.
+
+config SYSRESET_CMD_RESET_DEFAULT_POWER
+	bool "Power reset"
+	help
+	  Reset PMIC by removing and restoring power.
+
+config SYSRESET_CMD_RESET_DEFAULT_POWER_OFF
+	bool "Power off"
+	help
+	  Turn off power.
+
+endchoice
+endif
+
 if CMD_POWEROFF
 
 config SYSRESET_CMD_POWEROFF
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd06..d2fddb470bf1 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -150,9 +150,26 @@ void reset_cpu(void)
 }
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
+static enum sysreset_t sysreset_get_default_type(void)
+{
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_WARM))
+		return SYSRESET_WARM;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_COLD))
+		return SYSRESET_COLD;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER))
+		return SYSRESET_POWER;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER_OFF))
+		return SYSRESET_POWER_OFF;
+
+	return SYSRESET_COLD;
+}
+
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	enum sysreset_t reset_type = SYSRESET_COLD;
+	enum sysreset_t reset_type = sysreset_get_default_type();
 
 	if (argc > 2)
 		return CMD_RET_USAGE;
-- 
2.54.0

