Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ADCCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A6A838D7;
	Tue, 28 Oct 2025 14:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P4EqiizL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26EE8836D1; Tue, 28 Oct 2025 12:03:55 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A705F80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 12:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxn/+TA1P7mZxUmU174A2RtjWAZroehFTW0n/NOnIYrY7PCgqyU9uhRSR4fGYEwfhO3xmOOUW7w/RHHs4jpzCMv/V31CpIWOpXi0cjdjYAkoBfjkGvv2iqGaiQwigK0DO0/yKzFnMfqK5tFqksmQBtoOJ/0mOQSGs+zD4quGXXlOpR7FsXlrI8nmvlg77jpFYLZDbxy57tzgmpgv4wC/Iqs60/h7eqTqfKpUq355Twg7e8/ZrQdBxhR3tTZ2UXrtm/bE69g5pkG9t7MPqXsmuPQgbjuySi0UWJfFnW44ycVdhAzMV+yAGveyD66rv5KsV5Vt15L3tvkER4/uIPT8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX6daqGZIP4lBK8zXbc42aiGmxXeTTvUzXPOyEzsbzc=;
 b=WqnEYemcSVYgv7/YzfdWCK7+/WWMy3zRMD0SraBN6MeVn1W0BN5tub+fPJL1K+6qslD98T1yD9jb5W6yxs2xKVx8A5Z8/pwpZqpCtHaaPpvETQWA5gr1qeqTIgQLGS6tfBWaCK3Nq26mixf2iCYl2ebQepNd+IoWTVjyKNk7duetYfaZKfc7sO81dJWtJm9/OhYPTOA3vxlwhq/vfvrmUkitoJJsNfZZVDthRtHHUd4LS1QMz/6TCyxDwaUWWcP2HXtUSgcnkJDkU8MoVamxDCJQy4wPzTZBO6K6UEQ1ley63cHhrJSAPP6/fv+fqz3cyOwlUn2v5oVCxAybjK83Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX6daqGZIP4lBK8zXbc42aiGmxXeTTvUzXPOyEzsbzc=;
 b=P4EqiizLZS7aCL9qZrfaoVNHpZP2HFyf8Ul3PIWS4p3/5UcVptL0CK/cJezm74nCFvv60Lz+Hmmhe3ofYbT/GWYzlFYasv26apptUfRMgUfTwUGKVe9zckfQp3g9JLcZ7MDFaV/HUHSeuDcf+oIAplwJ9iT+StzLR8rxUkJKZVvlZmmSC9vx9YseCB2pp1MMPKgNJzH4d9mXm7O6OgpXKwlCeAeXRsGr2owPJWo3IOgpb2yhoxIBUHG4kDzGceRBiZIPK4Ir/vuBTqAIVrJvT2P/gx4pCGc3p2X9UiFwGsEeFyuGXhpsQVHIv35sFM9oDX1t5AubpSzitwLVuIZS5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11190.eurprd04.prod.outlook.com (2603:10a6:150:278::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 11:03:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 11:03:46 +0000
Date: Tue, 28 Oct 2025 20:16:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ye Li <ye.li@nxp.com>, Beleswar Padhi <b-padhi@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>,
 Ryan Eatmon <reatmon@ti.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 00/12] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
Message-ID: <20251028121607.GF9371@nxa18884-linux.ap.freescale.net>
References: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
 <CAOMZO5ASxBCdTQFfoUA7k5aXKwQZS+MC75kHw7uHoHsF1AgbcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5ASxBCdTQFfoUA7k5aXKwQZS+MC75kHw7uHoHsF1AgbcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11190:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff5d7f0-61a8-438e-c5cc-08de1611aa39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SitUREpNSzFsUUl5YzRHalNrWWpsclRkWm1ReURQTWs2TlZGS0daMUlFZzhB?=
 =?utf-8?B?QXprYkdnWnNFazdnK295Vi9zQm9mYjhSRXFpbUxRYUxhUzE1Tk5HaHZPM052?=
 =?utf-8?B?Z3JZUThvN09wbGFzZHlpVmFLOCthS2hmV0dXQ1VmVGNpdHh2QVcrK213dlVV?=
 =?utf-8?B?U2RwTTRYekVla3dJVnQzVzY5VGFnWGl4WlBqWS94Vm1vUGRFdFYzamJUY1Zu?=
 =?utf-8?B?dkoxT0YxODlnU25DSUhOWmVUeWJyOE9vZGU5RnNEY2RtcXR4MGNKMmhKa1Z5?=
 =?utf-8?B?b0w0cXhYYlhickNqaUtyS1R1aFRScjNWQkFRUjdTRmR4ajBmZXMyK3N4aVd6?=
 =?utf-8?B?d2k4UkxrRmUxZ0hHdFA1SEc0K3VBZWF5MWZtcGQ5bXNkZXh0VytmRm5lTm8y?=
 =?utf-8?B?b3JqOWVVblZpV1pLdngrbzdPQWJ4bFZDVFRRS2lKeWJkbyt2ai9uYnZtYUVI?=
 =?utf-8?B?c0xldDZKMDZ1cHlsV01oVDNoOUNmcjlaM0xtT0s1ZEpnTkdmWG9nYmZWM2FB?=
 =?utf-8?B?RGRodVB4b2hmWCtseTVDV0RweEJHeEwyU1lrNmhydG9DQVQ3blFkYmZBRVJq?=
 =?utf-8?B?dmErbW5NNlFiN3VXdys5NU9nY1d3NlFYRm5Hbkx3TUZiaW1qSmtZWTRlZ0lY?=
 =?utf-8?B?cTBhMWpJMnVwZG5WaWtPRTNvSXhYdnZKNTZ1Z2tORFZpOHNvR1VWc2pPMUFH?=
 =?utf-8?B?Ly81L1VmS3hLMVRXV0J2dHgyRWlnNWpSbitkeU5RWmJWLzZxeUFIMC9Vd0lP?=
 =?utf-8?B?VGpkbGp5YmRUcGhYWEhUZHh0Mkx6dW9oQXNxWVZReTF6N1hjcFZ4N1VVYm1W?=
 =?utf-8?B?eGorTWd6VFVybjJCQWhFd2xUNjRGVGlWM0c3OEZnNm9GQ2o5MFczS2l6UFc0?=
 =?utf-8?B?bU5ZT2JUVHg5YXByU2VoZ3lwckVCc2JxdC9UQXp3ZzJRVFdiZkhmWGFKREEx?=
 =?utf-8?B?S29jNW5ENk8vNGpiSXN1RFNNK1RCUWpxWXNnUmw2UWh3ZXVlVnJFc1VGY0FE?=
 =?utf-8?B?UWRoemQwTzRmTktYbGNibEJhUEVhMmhVSzQ5cU1LSGZPSDQ4Wkp2aVZkRitH?=
 =?utf-8?B?MFl4Wkd4SHRMQ2cxVzFUdzI3T3VNZkRQZkNXRk5FbWsyRmRqeEQvTlBTUXN2?=
 =?utf-8?B?UDR5WkVZZFZTd2NtK0FFUi81KzQyVUIyVzBENWR6M1FLOGxrZ1JpR1VCL3FQ?=
 =?utf-8?B?aVdqU0tZRWJSODRVYlZsd1IvRGxjRDdPTGFzeWhJaFhqUDVtcGdZNWd0Nk5j?=
 =?utf-8?B?MXhadWVrYlRoVDUwbVBGMGxCc3hzRzNCRy9ERjZoVXdzTThkVFV4YVorZ3Nh?=
 =?utf-8?B?S05ySytpbXJLYzR3T04wOFpXVkVWVFpIdFh6eE9ldUdsQm01TGF0dHU4VUlV?=
 =?utf-8?B?OXloWENMRWJrRFBMN1JxNFpnSWlJdGc5VnZYT0RvbWhmZGpvVWRuL3oxSnNk?=
 =?utf-8?B?MXMwaERCNUpOc1hyVWRIZXI5QmNTT3Z5TTRPSmNwMHN3U3cwZy9LV213bmtk?=
 =?utf-8?B?RVg2bGNIdCtrWnJHeHB0QXB3MnlhRkxKZTBqM2JxcERBNDcrQW44NU8ySS9Y?=
 =?utf-8?B?U0FEallQSGIvVk5Lc2d2Q08wUFU5eVFYQ2FFRVk0M2pWYkk5ZHVaS2tRNHI2?=
 =?utf-8?B?WXhMb2t5ZVhwTlN6MUo0eFE1NlFoR1RsZXNndWJDekVVSFpFa2RMTUxjK24x?=
 =?utf-8?B?NkFRdC9nelY0ajFzcjAvc3ZjV1JHRUxLaTE2eklVemtSNEIxWHlCWnVOdnNN?=
 =?utf-8?B?T0d4YjRGL3Zvc3prbFQwQzFJcnBCL251TUFaelFMVTZyTkdidW50Nm5VellD?=
 =?utf-8?B?eWhnWVNiMkh3bDFOaVdrL0NmM1g1bXVrbXdWSEN5cjU1UnphdUdPYlgwYUFp?=
 =?utf-8?B?ZlZMb3ZlZld0RHF6V09TSXZONUhFR09lSFZlRG1kRkN1UDVUcGtYWm1PdVBM?=
 =?utf-8?B?aFVJbmlwOUE5RTRiamw5cnJYOXcwRDdPeUYySGJQcHNEL1VKYWN3TDN4Qllq?=
 =?utf-8?B?aHJyOUpJdGp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJGT2hvcm10cTlSWUVsV1Radmw2ZHJBRmxnSDJvSTB6Y2VlT25GL3hGUWxx?=
 =?utf-8?B?NHRURE8zeGw4L0xUREVjT2Rydk1xVWZHNUlHenM0SEdFdlhNdGFTOVQyams4?=
 =?utf-8?B?ZmtweFgxKyt2ZkU5Q3dWL3dRV25aVldCRFc0ZFdJVXQyZmcveGQ0OSt1Z2ta?=
 =?utf-8?B?dmlBWUEzUGJJM21JWldmOVNRZGg3Q1VOeXZvYXY4a0hwL2VTTDBUQUx2ZVNN?=
 =?utf-8?B?Uy80U0ZGU0lXVVU0YmIwdDk0bEQwSjFSdGgyMUNNZE1ZL09NQUh1ZmdOR1F1?=
 =?utf-8?B?akdhL1pwVG1qVFhHZDNrNzREWHQ4a0c1cXFVZXBLb0JRcnQvVHNtZjRkNzha?=
 =?utf-8?B?VHJTYWdOT0NpcGdUSko5eTZyT25sdzJQOWRteVFFT0FyRk1lQmtLcTVaaXhN?=
 =?utf-8?B?SllOZ3Y3aE4rVktWZ0s4dS9zeWFwZnp2a1dNZGxBTXJPdmFsY2tzTkgvOG91?=
 =?utf-8?B?NyttSjBCNDcwQXlnOXowWXdsQWVFU2pCVkVkeFFqZ2xsdWNFOWNMaVRWaEc2?=
 =?utf-8?B?bjZPOHkvR2xWRDBHcXdodVZyYWg4UjlqN091L3k0b2x1S0hPZDhYVFFJYlpN?=
 =?utf-8?B?YTNRKzA4UGgvN1VZRnpTeDJmbTNEV3hXenhlYitMMXZFWmMraS84MlZ6VTBY?=
 =?utf-8?B?Wmx5TW1Md0lsQ3hzT2FFVW1IRVNZVTFNUFVPQi94TkxtcjdzWFJPaVpoTGxU?=
 =?utf-8?B?ZjVEUVVmb013bVlZaUJmQ2hRYTBjUkswajhESk4wQzJOT2w2K2gvZkc5c2R0?=
 =?utf-8?B?RjZCa1BwTnpWYkZnRFE3RE94K1lJK2I5eXpUcXNGMHVxbjIzZHVtcndrTUgw?=
 =?utf-8?B?cXluMjVmN1dJTVdRZW1YY1FhOW1lZGduL3lSc2tuVXB5cjI5bkNRVm5wN2dQ?=
 =?utf-8?B?T1llYkFJS2ZzeGsvMGZONVZNclBPSDNLTWQwMENIZEtjRlNGeDM3ZHNPS3JV?=
 =?utf-8?B?ckJENHRRMXFaOEsvQ0crS2xmYXZMOElNOU1zTHBmUzBZdDVRMzVsNVFoZllo?=
 =?utf-8?B?VElzZmZyL0lOcGhXMnE3RkdHQjNkVmNyK2NOb0orVWRabkxXME02NlVqV0Q2?=
 =?utf-8?B?U2xMcGMxSmc3UjRwU1MzN1BlN3pvZi9hR2xjOGNLWktmUDRabVBiTkd3b0Yy?=
 =?utf-8?B?cWRxQksvcjViSlNSUnV1TEVSVXh4KzZwcEhzeE5sQnVUQVVXY0Q4dFBRSkpm?=
 =?utf-8?B?Z0oyWUhiVVlvNVpQaFUyTmpPdTlOQURZa1A2ZjN6emg3bGk0U01qOFZ1dVhC?=
 =?utf-8?B?VVB0N0hwL0lyTWgyWDIvbmhrVXVRMi9ycCs0RkRuYVBJNlNwWkRiZzFGdEZp?=
 =?utf-8?B?a2tTT0hkRzNlV0JlQzMzKzJLdDFpYnVOeWhkTURUTUcwY2lxNWxQcTB2ZTFl?=
 =?utf-8?B?dk1WY2xzSkNvOFRxMURvcWlROVFaT3pLZy9BWmxMK3JibTRQVW8xUlpQV21E?=
 =?utf-8?B?a3VKQ3J5Rm5MVzBiWG9rZzFpSksyVTY0eFJGR2k2Z1N0T3FObXZwUUV0L2Z2?=
 =?utf-8?B?cVRUd0M5QVdWRkdJQXVNcjhjaWhWM3RFS2N6M2FsV0k3dU1mNnlyeVVMZ2t1?=
 =?utf-8?B?ZGE1cVdLVVR4MG5iYVBBb0tQSzBPVktwWTROVHMrVzNkY2RiMG93aDVFalNK?=
 =?utf-8?B?T3I1MG50MHdxbjljejI5NTVRMDBHMEZoT005MHRHTlh3ZWhpME1MaUN0YXJl?=
 =?utf-8?B?RENhdzBZZ2UybE9CRlNaQU9PdkRlK2lBRVlVa29jaVlDYjJDUVdaWmJwL0R5?=
 =?utf-8?B?MEhNL3UwMmFxRUc2anl1MGV6UFA4by9VUlpwYWd1RTFoLzkzbjRuem1ydFNJ?=
 =?utf-8?B?YVRHOHhoenRtbExOOE0raGdhYUxjMGhaMy9adjRXNUVVcnRsbVJta2FOQm1z?=
 =?utf-8?B?WkZFbllDRWRDYmlKYldaalRhVVVVNENMNjRGSFpnamFEZlZyai9HcmJoL0N1?=
 =?utf-8?B?SlNvbXRMUU1BV1VSSzZiMERIaUc0NHFMb1Q4VnF3U2NYbzUzMDJ0WjFvdm1p?=
 =?utf-8?B?bTBNVldyaWV2OEY2RG91ZTgwVjUxVFZBRVV3WXdma2Q3aGNXL1ZRWHpZS21R?=
 =?utf-8?B?a2Q5U2kwTkM3TXNRNG9lalVlZlVFdmg3SnBsRnRNclRzUmlSSkR4ZXVJdWd5?=
 =?utf-8?Q?SryLo4MfFbeYDFFPHNfRzCmN2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff5d7f0-61a8-438e-c5cc-08de1611aa39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:03:46.7680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGQz45sBDBWXz51gGTbFFFug67JTeemjsLAJOW8DRa7S92MS2a02GbNGtbJYYw6pbs0Izp0rkf2qZoztuFXKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11190
X-Mailman-Approved-At: Tue, 28 Oct 2025 14:10:51 +0100
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

Hi Fabio,

On Sun, Oct 26, 2025 at 08:28:50AM -0300, Fabio Estevam wrote:
>Hi Peng,
>
>On Tue, Oct 21, 2025 at 9:48 PM Peng Fan <peng.fan@nxp.com> wrote:
>>
>> CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=21
>>
>> This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
>> platforms. Most of the i.MX-specific logic is ported from the Linux kernel to
>> ensure compatibility and maintainability.
>
>I'm getting the following ut_dm_dm_test_remoteproc_elf error in Gitlab CI:
>
>https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1274168#L276

Not sure why it fails, my azure CI pass. 
I build this with sandbox64_defconfig using my local PC and run 
./u-boot -d arch/sandbox/dts/sandbox64.dtb
With command: ut dm dm_test_remoteproc_elf
I not see failures.

Let me rebase to latest master, push to CI and retest.

Thanks,
Peng
