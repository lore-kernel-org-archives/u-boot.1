Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF0F5581E
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFFF842FD;
	Mon, 20 Apr 2026 13:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MGNe92cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7468684307; Mon, 20 Apr 2026 13:28:14 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F14083E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwWX5K5xmx+RoT1MgpX2PeDwz7w+b+JVCN4uh6sxx7JKMdy5xJo4M0V7HozEdwc+gFNaS1Eh9Sre3XtJAYKP/uVt+TvQJSaZDEnW63/+BESPZXlzkc3p0PjWN14+WHU3zCnn95yZGXi4mbfaPh8ac7YsfaTORbB+faWf4lmsnbgnRK1MQwbxSP4UKjO/0cQ+6BABrBTMruQF93knMm03aNoezLztUgZAx1+DJXCtOTf05nQ/tlriOwDNFdIMArmOd5VC57dpske6z/7dOsCZB8C6dAJgytaA1ycps73OvORI4TsVy6o7Pn7Mn6peje9/tP52Q3W/L/2Or+2qbJSz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm00uuCFKvCvozzoAn95ToIMTMrfAk/+WCpwJD0d884=;
 b=yPX57NEjCl6zkrsc2+ojxxVY6kjKWBkyZzbRGBVQ7JRiIUsQLV4xa6V8wi9P5NxYeKUh20iarYW0aPnczMRyJulKF72rhJjylmMf3itYz0JYuPBN3v+F7SmOxbnDDetez+a87xqBdP2TzMaD4IzGworVMrABfcGmp4pOyQ810GY/4YQZs5wE1KXdlqyCZJrCuKX51qX7GQ69WG2Btx0lH4zX/vP993KQAXH2P8eTtAMBU5UyNw7dypRkh/N97rNBV2aWLNlwaNHEarEhDuKbC5bgAbK3S4Cz6hOFPmClyoXql2A3XFOCXBRpoGPQ5cxNdU5FHwN9vLohzFM1o7aA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm00uuCFKvCvozzoAn95ToIMTMrfAk/+WCpwJD0d884=;
 b=MGNe92cm0JsfHZeece/ojMyLhLSbfaTMFPL/GSnPcMl2H8dzM2fjQGbw9ayzcy+Iwv4dlfvg/AxspLtjH1jXO8jV4TvBEtASE71z28BSLhpaCcv9/qDNq9+/jJuC/01zDZZCD6uoREnuUTTOD8kk+D322/44SFg7bnOm4TTIADjcEB/kpZecu+An0SnmqmD9rS/BKn460+y5I7qgvHqbeqoTbWty2ls8dz5NQ4o6kNizDeQSXCmqgb5Yc7UHP80QMb6J/Xo0pzxWVZaN87N0zvGrklwedjl3xIjOhOYmx/Fevt3zeSpXpT2BRFenfIeZP7h+Bvu9W7WaePVXg/roHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 20 Apr
 2026 11:28:10 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:28:10 +0000
Date: Mon, 20 Apr 2026 20:44:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mathew McBride <matt@traverse.com.au>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] configs: ten64: switch to OF_UPSTREAM
Message-ID: <aeYfusJCVZG0CJKb@nxa18884-linux.ap.freescale.net>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
 <20260409-ten64-add-usb5744-v1-5-2094496f72c8@traverse.com.au>
 <CAOMZO5CWk2pC+RPxTf4rHTUirmC_VmyvAqp3r==ydO_-UNLEBA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CWk2pC+RPxTf4rHTUirmC_VmyvAqp3r==ydO_-UNLEBA@mail.gmail.com>
X-ClientProxiedBy: MA5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::8) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DBAPR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2f7ec1-910f-4ab3-36cb-08de9ecfe70c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ud+/uoCYAqVLaa6xWCMFnng3iGw31PkkbfWfJRE/UMkzAGqg2Lx38jqt24rv5SDiMg0eaKdQx6gd82N6qQe4pZ9kUF1p3r+n0kqMS8iZjqNmCMfG46Dm6ezuwEpZRWTmDIQZDOQmj8hj8EtWK/TlDTx8bEbsDJ9qVz8mwxUPpj79AqqylpQ73YXm7oEHsDvCLaIKpG46c5yJ2A4aW15tciSNNs5Q1qkbdrBR29bFIubWjl630TcqBuazqjGLu/nCHdByLajAoDFIpudiDIX/nhKdznxrV6w+AjCC7ZjiRpmfdB9Vtw4y9N353lEzv95XkvrFjCFGM3xtQrjOXLAzEVOHcV08QSkr57OO4dUpTeTqAw/O1ooDvSzLyu7pKPjnszAaHq750IYlOw7GzR1vSU/TlBpxHixelmc2C/lnrM8878o9pIbEIRS9Tkd5FG+SRfSXt8JRhKW6uOWIwzN72U42gLXmKKLC8gNXJVj7w+Mg76D7K2q0g3uhYd/oiHQGI61jlsR7IOHciP6n7fRCIlF74iEs86KaP2AZvGSkEnPljg+o7LdQQcDERdyINftJtYL7oXeaqwa614LB1KzIcWXhqdK12KQ5YLoo/XDVxvHHtt+VRWr9MKz8E3pcjd/eiPVmjDaGxAJNraabKaR8v44t6xB9PRErJJnYRDIKzyfjB9bojrqWzrzepwbUXx2cFmneAisMPFTEvNSA7K2QPsPEivAv80bXW82o0vH+D4ePyIK+fhA8Eu9h6BuP587+ETfcH92WbZtzhA0bq91luPbfSfs5dwPSI5Pa7QZk8IM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G5EwD+xFX+nGrNicBiF3fbrK3tL7Ymj31S4nbXWLbmL0u5Tj/5W/hwYuCYzl?=
 =?us-ascii?Q?uHrEdZuvuC6IO1aTSzTYmbZuLFK7BSReRa7Xbxw34kfnuiuOktq52PHtM7Dp?=
 =?us-ascii?Q?2Ocq7UzYPBeMNLXwlC+vueflR1prBdmx2cfFWXk8EmSEimC/ElzpbFwurVCB?=
 =?us-ascii?Q?70YuvPd4NRucGUHr/qPgwBTYALh+WkuIUapKOk+Ga1ipsFMtGSTZms+s03JK?=
 =?us-ascii?Q?SkdzLeaiHwNQGkixrTxJyN/u56jvL7ndLRWYzz0K3PUZioMNncR0KeOtWc1A?=
 =?us-ascii?Q?ijlTRXop/o+DcHVXrk9PSHD4QbCI1WMbnjt3+nltZpIi4LEuK/dcXaBr5BiH?=
 =?us-ascii?Q?TAYw1Fg8c1R+RVzf4VBiuexJ6HmfBUGb/x/BiWAlh68ZFGxOeHo74TSvNeZk?=
 =?us-ascii?Q?llmOeAVnyLVu80m4h+ABNKkvkVfUn179dVkhrbhONqUhJe3UKy4bTpfVyTgl?=
 =?us-ascii?Q?xSBg5wYFIvlape3HPlqsKTLyUKRejxXirVMPo8EZILWHal23gVG85jc1wNls?=
 =?us-ascii?Q?mlVx5qHQje7/R8S00KyrbbW9796MVq682RC5xKv5vN54fnnPq/pgchIboNW8?=
 =?us-ascii?Q?SG5mPjqcy9/bd1BeQ2BO6YrW5luWrE10vpDjg9QSEPMGMd63Z5rbq/QzJ6DB?=
 =?us-ascii?Q?tqpaewIkg52NynoPwNFLUSzojuPFstRuWW/AIQcJl9kfQ3hU1cPmBa+Rai+1?=
 =?us-ascii?Q?9SGX785HiEuZ8/16Dw/8++jlaRIqxmzXgpdCqTc2HDqPw/vuQpISs4jYC1wu?=
 =?us-ascii?Q?ees39JBysTcGqCYIEYAg4mWUxv+1Gf6NjvZjhBiQIbZ+7+3B5gp/s+TaCDVu?=
 =?us-ascii?Q?4qsJfz13R7UZso9klZqxgo94stNXqBUByy/ZnU59WrFaQa/cQKq0EUwQWQi7?=
 =?us-ascii?Q?5w6xHjJERPZgs6qZuew4LEgYn88gIPFh92BgFunPXi/bJjmC00/hKOjV4gMM?=
 =?us-ascii?Q?6pPLriGadrssi9ItQYS6qZ4Ys/98suiZSEmNIV9YYnumIK0kFcyOaLHRNpMx?=
 =?us-ascii?Q?mY9/08gz7QM2/1wZavAhvg5J3ii+MNXbvI/nDrVCecQMU+wFg98l6bIkObWm?=
 =?us-ascii?Q?8VIjJzOU+j7yRzXx3Vvym+I9qIV9HNo/5OBaBKBq/9Q9wRBoIj1Gob3DYs2L?=
 =?us-ascii?Q?Uq/f7JYvI9hrUP3K8HCPNeMGdgA4zVMktKkt2tkqKUizWFYE8n7esndKgI+r?=
 =?us-ascii?Q?SbsJCwB11VzynI/klLzKfx7V+NzmTYDd7sZHiSYG06CWKdsjwfTKFfQipHPe?=
 =?us-ascii?Q?Hv1rIQXibUEgeHiZMA8fJ/SJPQ4o/NDAUBWGHSRSYIbva3t9SF8mbNY8If2Q?=
 =?us-ascii?Q?5KU0GE9VlvhAXfnNzmtFub6sJBQjOdC6InncAcshJwVD7UPuogQ0Gje17m3o?=
 =?us-ascii?Q?rOXv6RRJHguvbleTPlY8pc36A009nBzWsjU6UHCor2FUx7NszOtQPg5JTNqV?=
 =?us-ascii?Q?PKoYg8Yo76kz2BrZcTQLtbBP10XrcPhxpr1DHGLMM+4yJblCsFNC8FTO1Hks?=
 =?us-ascii?Q?5lwJFUcrBSSfeX6gCmT0fuqDNpIFN4aAgeERKB2VwRnPaYM2YKFcDdroJ9od?=
 =?us-ascii?Q?bghrUVh2+T1n3mxJAJF6C9+NbBXOuIHbi9yyjTFyAIOFrdIJOIDjrvdSrhi7?=
 =?us-ascii?Q?w5cjWc3YxkP9nI0gNRnOP5W5Z3QWNI5Ivpu66VpprP8mZ7Z9U2fPRtXUtWQ6?=
 =?us-ascii?Q?jV5nSx5E7arobbyJ/UxJlo3wDm+d9NNwLSP0C9adNhhYRnn8mAfBHtQQGVu6?=
 =?us-ascii?Q?ZIFW1YrE2Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2f7ec1-910f-4ab3-36cb-08de9ecfe70c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:28:10.7312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2OvJ+KjqMsp7ztcTVN2mDYNbjp1nzpQcRLn/h+Jwnx/aypb3fK/VaLqbNAewArDsAQCjb961myRu3MVmC22Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7462
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

On Wed, Apr 08, 2026 at 09:51:48PM -0300, Fabio Estevam wrote:
>On Wed, Apr 8, 2026 at 9:26???PM Mathew McBride <matt@traverse.com.au> wrote:
>
>> -CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1088a-ten64"
>> +CONFIG_DEFAULT_DEVICE_TREE="freescale/fsl-ls1088a-ten64"
>
>You should also remove the local U-Boot copy of fsl-ls1088a-ten64.dts.
>

+1

Thanks,
Peng
