Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543A4D5CCA1
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 12:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919ED88F83;
	Wed, 30 Oct 2024 13:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lZBUdfqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF75891AC; Wed, 30 Oct 2024 13:40:41 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EA188F47
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQtLEVVhartd4fbG5WtABPPKSAGctcBB+JjRtf9Ra2sdXzVsHRJkW4lQu2mUaWhsAdSU5CtWNN7ljz9i7Sb25mQcVCf8+a02Q8AsuyY/rLZWQo3fq2yd2smKGDAymQVnSzfCiX3EkrcxBdyQPprrshiLYNIM9bPfywgnrS1WsUkoYT37v3tHbAx5yVWn0GNOA6bABrGZn5A2nGQhOajsrItR4M+HSTrPb1YO6CozlCuwzFDXA+pWNLmDmnkuNhbwXxX0HvB5X59q3NzMzqY8DCCk431PRuwKOA5fp7LrXgTsoHF7zQ48oEMv8/hGnFlP2KdlgNczgA35dqhmmQnBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T0Ls7Z7mkOOMcOe/JYPa5Vm3Zuj2iOI63INLszveR8=;
 b=B97r1Bp9aG3nediyamo1brEbGIP6L7EI3AtDCxvwd0KirB79Qgz73j93dvTAweQk9BRWOVqx+GVeZrJFxTniJYq0iVohQwDwiH153mGDXr9If2Gk6Y1KHbJ5TOi26oglOg7NK7XkJ1J2qGYTMBWbrlVacRhdw/JirgGUFAVMup+NiGYSBI77CL58mYbMDn+b7ojyN9EC89swGeNkSjYzfrnZoP+AloHvO7bw2frcUMVKefIdIgwJFA0IR7y40bJ+MhRd8KH6i6ULI6qAihsvCc/UphkrDuw2cx4irSem+r98qDQt84BOtug7xpuR4CHOWbPuXysXEMXZpzWXLbls1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T0Ls7Z7mkOOMcOe/JYPa5Vm3Zuj2iOI63INLszveR8=;
 b=lZBUdfqxyORx2yVoBpugj1RfKmzs5V8sPQC8BYcT9TWjnFLVwCCvaVNQBOVXpn0ej3vCnZgoyDh0IrIXURVSsaqNMGK9PCsJJAs1G8SS9qmLqq9PU6pZtiONU204N/HrR1i0m5Mmy/T+GAaj2bs6h3Xuf42eeD7ctkIiGtDU6+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 12:40:32 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 12:40:32 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Simon Glass <sjg@chromium.org>,  Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,  Tom Rini <trini@konsulko.com>,
 festevam@gmail.com,  ian.ray@gehealthcare.com,  u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/2] binman: nxp_imx8mcst: read certificates from
 input path
In-Reply-To: <20241030080753.129-1-brian.ruley@gehealthcare.com> (Brian
 Ruley's message of "Wed, 30 Oct 2024 10:07:51 +0200")
References: <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-1-brian.ruley@gehealthcare.com>
Date: Wed, 30 Oct 2024 13:40:36 +0100
Message-ID: <87ikt9kbln.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0073.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::23) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba11290-c3ea-4883-4e06-08dcf8e00b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BjAMzGyNOaSscfC2JyykllSDx4r3Re0v+j+BN9jFpbMqk7KV9ETT7XkOvsNd?=
 =?us-ascii?Q?ePc/+VX+TsXshjbPVfhH/6Sry1UkO9Tp3LcQOt+xMsGPSFewN3+onnuYY5mS?=
 =?us-ascii?Q?TYty10R4npExuI5fySLOhhqEQyEsfqG8njP5nQfwgjcdtC3htpxvzHwnMnzL?=
 =?us-ascii?Q?wuY6a1v7Gx234Vy2X84DL58lsTU76IGWV3gG9WC2n+Wcz1fQbmEFiQPbpRTR?=
 =?us-ascii?Q?Mwpj5En5MSFZDLnxG8EyCh7UGTlzxYt8VDkUQoJuV+XdnvhLVNi5JsZ1GQml?=
 =?us-ascii?Q?a1Pdi1eSTiDfYsjjoNAml6WiSdQOyDFqfPMnjzRYsmpyR+D2NduvEkFUKynb?=
 =?us-ascii?Q?CCk1uDUiolQRBvvAPHkkQYGyGvgJRhpDQgtS+NEOF/GMYhDUtw3S/ALXFT/L?=
 =?us-ascii?Q?Mx5wTuTUpvyu9eZuXF+qYdcmlrlVQ7eEaewlBRs6jMKSC08kkEdDJ9QQI0/o?=
 =?us-ascii?Q?bUL1WGS2Z0wigQghVn0qWg8ZblUBqBi6oTHva10TAsoPEZXdCmxQsqVmEa9v?=
 =?us-ascii?Q?T0fVpSXOYecwcLi5V35noiM19l1ptVdr2HH2avGXljme5aLCwnF2kexWS/ux?=
 =?us-ascii?Q?/gmbgY6+wv0Dg3BIR634lVT9xQNneCJKS/Q1P/MbUQClJYNgyPbAlmbDmVEr?=
 =?us-ascii?Q?HKhWYEA5ptD26jKPol0CgGi6FQ8cHN4hmhne/saqq0SL0ippitKY4tkQUcOp?=
 =?us-ascii?Q?OH5OAJQKge042FDErlko5mokJhNXDQwb+yfHGRkiSNylPCMEZnIy9iUd38Bj?=
 =?us-ascii?Q?A5ixzKVVJBAb4Uv6A9nR8nm4Qr6fG2BMQd31tmQAKNhUhJDNhW/oroFLAF2a?=
 =?us-ascii?Q?xG2mNSM+GeCpz4RPvkyHfSCT6VAo7okkwcZCcAV2jnuFwxUwJA4367vwFMRP?=
 =?us-ascii?Q?/oZloIHPIVuk5kJ+z8Lcrc/RDJF0UAAKJ9hOisu3aCmLqKPNPNQCzZ7wNgiH?=
 =?us-ascii?Q?BqW+xueCWnB22XjDFYJTXicrZN94KBpwNwaxeuXcEHA4q8uabe4Qvv98SO4m?=
 =?us-ascii?Q?LH0Vgy6gAmfMJIZUuaJKJJOJaWIvlVVAbq3wPn46DVDZrs0GMnJS3Eni9OP4?=
 =?us-ascii?Q?RwqtkQedVQ+Q9XWN1MsIhLgJt+8GgD6Uge09nxUjXPLzdZ9Rh4HX1i88J5FQ?=
 =?us-ascii?Q?0z97TYOLttfUukxmcgtXPAaEMD5XT2DOmpCkRcJL7+SpT+ZwcBsccHFKzO9Q?=
 =?us-ascii?Q?Grr0swTZmKXgY4p5Q7Szc1wrs/VroQt8AzzHY5wPYpY9/c+TmMITRPVjG4YG?=
 =?us-ascii?Q?dpqVhVQZnBY6rreccOtSgHnO9UFkPA3Tl7YPVvO6AIn/EV0SBS56LSUfhNSY?=
 =?us-ascii?Q?Bg+HvmGhWxzZ21Rlc6OBJaM+1GQzK2verLwK7N72+nTFDz0QrEzow2vJ1bDH?=
 =?us-ascii?Q?yscGtZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UNbj29xvTk3uFP7CUBCPNGDNFD5QO9pkJ3IS8i+MvUOt90a8yPhG3eBJmrsP?=
 =?us-ascii?Q?axSVeo9hzlX+pdBn4tl2+v9LtL3wTA+iMuRbo/Lu3tmpKM9uKyJ/iA976NPf?=
 =?us-ascii?Q?q4mWUqUH8XTK1Es4onShQ4sUAuE4WLtI+plk88fHfMFxBBMqdsDgf7dVmFfX?=
 =?us-ascii?Q?z6pKGZQHymNnTMUtnHYgAkUrkQ3YvbdsMx1rPvk9uabj3MnuJ/PbG+DxV/yd?=
 =?us-ascii?Q?F21xvLJf2E/kNL9O5Re1A2HJ8kAHyyOfxXgSQTuRdLVGMFM9iR1PissrCnwI?=
 =?us-ascii?Q?DgggLJ+FpiS/A+85qK7aurE5VoQnOrq+QEfWrBBB8wEv7G8HLuSWi9s/5du/?=
 =?us-ascii?Q?d0Y8oolVxsE0crBC0iud754m/kFDeZhXibPb9Jj78cXjVL8lm9RUqXdr3enf?=
 =?us-ascii?Q?AJL0kcdZ4uUHsJnx5ReEdle+Y+bo4ArtBQwLeUAStwFejk58M7EfAYGAlPUj?=
 =?us-ascii?Q?Wy755FtgV1owjHgdsYk1gdswOi281ixuSUMrpRk3/3JzGO/oPOa7eREPHzLn?=
 =?us-ascii?Q?/CuuarNU6T5PlAgchO1CsBW/zqlYElmi3maSuBOUvQVy++0ZnSu3XjNIXgk9?=
 =?us-ascii?Q?0PIJJLW4RKZKXp9NqwozXAji5Ev0G6IFdPXh1F6yXFig4cUhzzVhVT6X13B8?=
 =?us-ascii?Q?/wEKsDthj5VKet7ivyvE+UnEZ4U5rfS75ygp6a/D3r6hwYMjqiCKOs7CfLCT?=
 =?us-ascii?Q?pNzprsoF7CH3k20feZY4yqZxeOWnufQDO+dFL5XDO+ivW93Bkzz0JFHAYNeT?=
 =?us-ascii?Q?6o2koV+7SjMaZdMvGMKDi1EbWEjOQw+66uNLE2ms5NoK07M9jOOQIYZoZ+W/?=
 =?us-ascii?Q?R0YDzCoB3rUimqvazWRdgTfEq4DI3qFhkv/gCpP2B0lpxpgf8Jg2CgyBPHv0?=
 =?us-ascii?Q?buJ35ZkDd23XE7ls4tLyw9YIMyhQYjCY38/YabOQjUkSuumgTTOVbgMEwz5h?=
 =?us-ascii?Q?JZyZuHKwQ6Rc6ognuzgSHF5AaW6uDAy9+NQtTFw69NuyfHA2fcaSlsOVSLpu?=
 =?us-ascii?Q?87RB+YeXQjB4W1UpenpSSNSQvhGH98iNfL1amM7PttY/vLk0aJd4K3ySp7dc?=
 =?us-ascii?Q?MC04hUXTdT8fiU+riMkfjOnj8FfRAKQqyhIvAk/DuxEY1cfDFVGUaJBtZilT?=
 =?us-ascii?Q?Ji0q24pFm3pbOXYNdxzLJr0Su2T4DVpam0YZzadp2LsLisXGLG3dYdlC9qeH?=
 =?us-ascii?Q?/1iY1CVYXAzIFiYc43t8pZXOI4mPMW3WF6CyJt8fQfeuH+rWBJ3DVW9usw2/?=
 =?us-ascii?Q?mbDaS67dj/xvxT2lHTqn/V48iEVSCfxl2jykrbQK3rC1MaLDGc754yFyusjY?=
 =?us-ascii?Q?qjJq9ug+n63b0PPMMBvv8yBJroO//dL8nvU7IfDpO+aujtDaPScXBrE+X20s?=
 =?us-ascii?Q?9u72AGYuQDolBGR3bTKOfqWcy9g811lcvPd91JiiJLBwjRrv9BD7tgwKMgPk?=
 =?us-ascii?Q?QRC+zF2jr6jmSO/pF7OUb4iXESrD44wp2CEBXHWlwFN0RAuxinxFTi0eDp68?=
 =?us-ascii?Q?H37FVHzDqzAHdUtxkY1zCWVQR/GXmFc1eBhIIQMP2WlWYnCn+VhbkoJqv/FL?=
 =?us-ascii?Q?bn4V+0El4XHmSP59qdGiRcDx5dEjmPKfYXSWifsyr/P6E2ZRgjtgY0lDHI6e?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba11290-c3ea-4883-4e06-08dcf8e00b33
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:40:32.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOgoxywc20yJXKywjzkwqJgbsFgrx9P4MkGRY6L01okrOcSvi4NWM2psPg+K0qu9GA3fkvuHYfmSu+yxuyIKfsWSLy8RM+HzBLYV0AkC+qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6733
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

On Wed, Oct 30 2024, Brian Ruley <brian.ruley@gehealthcare.com> wrote:

> Right now, it is unclear where the certificates (and private keys) are
> read from if environment variables are unset, and providing complete
> paths in the device tree is not ideal. Naturally, it makes sense
> to be able to decide where binman should look for the files, regardless
> whether the keys are specified in the device tree or not.
>
> Therefore, expand the etype to look for the necessary files from the
> input path. Introduce a new variable to provide users the ability to
> specify a custom path.
>
> As a consequence of this change, the environment variables used to
> specify the keys, e.g., `IMG_KEY', will be searched *relative* to the
> input directories.

Hopefully not if those env variables contain an absolute path?

Rasmus
