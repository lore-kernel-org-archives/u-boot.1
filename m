Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F21CC8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 09:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A861C83046;
	Mon,  7 Jul 2025 11:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tdm4JTr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FE18304D; Mon,  7 Jul 2025 11:46:46 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E79883043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 11:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ietxsusuIHyfpmN5p8WNBC3Bkqpng0dyFRVWBgoomC4Bsi3U8WnI4nWaKQGt5eHez+4gdhfmXdkMOlf3geqqFBurWV4wjh+oZUhxMusRKQuiSvvwVMHSGow+XYgzjXhFml+g2IISyRpAfu2cUhMxfdXVd0bvBf+txwXD+uquVzzzHKKpg266jgt4/XV8O3WV9Wdj5q8uOx5OZC1RexAmH6qx7shjBMKA0fB/NXNsU6dD59xZT0FKwf7WlyV1xo86TOoawcHCijk/0aIoAKPs5Ea4hsuLrJ3vZTcPjf5Bu4mw8hOo63i2T/ciWjCsClnTPT/HtWomliAnyNiH8T0Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8VJ5CoOlGUdz9zAR0CbN/yiO9kScNfW3ARnllLide4=;
 b=apx0pW6zS3APT8JxAIcoQoAjcgvsSrFSr0KuOwQI/B+INoTIqdMhnh3GIPCoFu0g0EUsgcjTDQpAOfrvWh/ubkpYt0HGhcXP1GI/htUqgii+ilApyF35gu65vYYwQz4zgp8oM+2lFfs2b3G+R5utYqRsNrv4lqPiIaTS5msCXFebRHS+0atN4lD4BNFDoqC+hG7ea9i9Qb4qbP8wTDCVKbad9Rko+GIszjRqje4Ga5MIIe3ReQ4z8mZGVGHXJatpEzdTqUaAaw9c4PW/2mFByRg+SlJI4AIeg1JFHOszi30T7m4BwrjQehUlSZuhOtvMOdpvru55YiH74iM9txALCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8VJ5CoOlGUdz9zAR0CbN/yiO9kScNfW3ARnllLide4=;
 b=Tdm4JTr/cqDCpA7F0xtnG+7Vl0Ko362H0OzGcowaWS28mlRUVMZS6DU7/ti07NPYWj3kEmtulS8Crsb56hnXKFdO78PCN2S1GhP95k/rMBTKoGdorTTaeY17nlfXGyzGI66K4Ol7nMGVt2hIm50uP/EE1GOXjBMi1O3RokJ4BHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 09:46:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 09:46:40 +0000
Message-ID: <650bfc6f-d519-43a8-9e9d-9010c833c162@amd.com>
Date: Mon, 7 Jul 2025 11:46:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] cmd: fpga: improve user feedback in case of
 bitstream load failure
To: vtpieter@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
References: <20250705205710.792370-1-vtpieter@gmail.com>
 <20250705205710.792370-2-vtpieter@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20250705205710.792370-2-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:803:14::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a38629-6197-44cd-7487-08ddbd3b2c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW1oMzRiZ2diTG1qVFJtT0ozR0IzcHNvMHB5aFR4L3NyK2RhU3o3MktXcEI2?=
 =?utf-8?B?KzVaeUFMdDIySzA5Snd1M0JKLzVWOE9aVGVxZ09PMFArVE1PZE03K21idy9M?=
 =?utf-8?B?d1dkejFLRVQ3aXNEVWpJVXUxdkEydG9rUHpoOEZkMVA0MXRSMlFva2Z5akdJ?=
 =?utf-8?B?SkE4TThUUTNHVW5MWU4wbVNrcDhDK2IwVjFjeVhhUGNEZ1FwS0R2R2VmeCtM?=
 =?utf-8?B?TjN1OFRKSVMyTFc1OUF2UmkyeXlDZDRaSVlxa3lvbXo0NENtMnpkRXhSRXU2?=
 =?utf-8?B?dk8yVk12Q05JOEE4ZUthSjVCRHBEeDdpb05uNTZjTU9qUXE3Sk0veWg5TWcx?=
 =?utf-8?B?RzlDd0hNSjArcTZ6WXV3eEZBb1hkQlNpYmpkYWJSdmJYWmhvd3QzRFZwTnlJ?=
 =?utf-8?B?Y1Q3ZXpxQ1g5bkZ6a3pGNkRDUHFKTWdlWGVWdzQvT0JlZVJoeE54ajBPSCt5?=
 =?utf-8?B?cEZPQVlLUTlHTWVqMzUxUWNzdVVLUlRaKzlSM0RKRm5XN3Y4aVlEMWtZemE2?=
 =?utf-8?B?ek5vUTkzOVl6UkQ5OFcwUWFkbHFVS2E4V2ZXWWNESWg1ak9DZWtlbm9WQ2p1?=
 =?utf-8?B?bll3aElYY2ttRlhPeHBmUW9iUkwrUEdQSndWNUVIUjdYbmhWQTlvZ0lJTmdu?=
 =?utf-8?B?bEVTY2VVK0EwaHBCTnBKVURqRFNDTHBYWUJQc0NHWFRkTU12SFNIWDlxa0Ju?=
 =?utf-8?B?WWdhb0MzVTZxRXM0eXFqM0FUZlpWZzZFT3UrTnhBWkhTN0ZkbVFpSU0zSHV6?=
 =?utf-8?B?OUl2MWJPcjd3a3dvcjN5UXBWYmgveDZxaVQwQnBOVGxudFVIcFZXSU5hVnR4?=
 =?utf-8?B?ZWo0dTNpRnBaNFRuOU5RNXBsOEdaKy9hVEJiM3gyNzlMSm9qeWF2OFUzRnds?=
 =?utf-8?B?cWpraEV5YzNOUFNWZ3pBVEtxWDJRZmVid2tYZmxvUWRPMG45Uy8vbTNyWHRv?=
 =?utf-8?B?b2d0c2tENWUwTXZMZjh2d0gyc1VGZnJwWWtxUXJZcFNSbWJDeTFtRlNjaUxS?=
 =?utf-8?B?TzBlODJheFJaSGZIa2tBWHFpcmlwellpcmpnQjgrRjRtQWYvUzBpbkg2a1Fi?=
 =?utf-8?B?KzRZWitFb2hTd1BtMENlaGlsYjZ2ckR6RGhOVEVtVXZicU9IN1JBOXZMWnZI?=
 =?utf-8?B?K1NndGZGVEl1OFB2N2hRdmQvSy8xTkxXVVZTTjZLTzZMaDNzOFZFVlRIZDhY?=
 =?utf-8?B?MGZKOG5ONUVHMUdWU1d6c3kzcVY3UWNKU2liTTJnaUFMMFFnYmhVbm10Njdq?=
 =?utf-8?B?dk83STBKSkNpSmdldHcxWlVlVUZZUnVZM1V6N1BZZVdRZVdwb0xSMnNzTEl6?=
 =?utf-8?B?VURRc0RKb3VHRUMwbDJ5SXRGUDZYeVpUZW5hajJiOEwwTDlaMG9zRXJyKzNy?=
 =?utf-8?B?L2U3TGxyblpCMXF3ZmZkYkNlYzRWWnhVZzNSVmZ1cDloOG9Ob3QrakNIOFcr?=
 =?utf-8?B?b3hFdnM4VFpNbXIvN2RWdmxFdk5mWWY5UXhuekVNeEJld2Z0TVR1TTVCUGlL?=
 =?utf-8?B?WWlVS2xrOXRBUEd5VXlna3AvVXh1RDV6WU1TNjVqVkMxZXQ2UnJQVW9OMTZM?=
 =?utf-8?B?SzBmTGhDajFBaElYaTQzem1wVUxpclIzNWx6cjNGcG9mekVuVCtsV2tUdUt5?=
 =?utf-8?B?MWhvUjVDdUZyanZuUE10TUtLY1cvRnBVTlc2TFdvRzlldDhqbVovRzRPdGpw?=
 =?utf-8?B?SzNDaWV5MjJ3Y3EvTXNzSE5jZElxK0JOQnljUmdXdkxhV1VMdnBXMEV2cnQ0?=
 =?utf-8?B?ckRoMUZzcDFNeStBR3BwaVNMT25mQ29vWW9GOWpYYUNGMmFBTUdWWTRNQmsz?=
 =?utf-8?B?RHJnVGhRZHRlY0hTNkJWVEx2WmZLUjZkWis3WmovNnBiNlRwTmJ0dS9UNUpm?=
 =?utf-8?B?SENrMS9WR3FTMVBHQXlZMW9aLzM5Z2c5Tk1aVTVtWHhRSCtiQzlibUVodS9v?=
 =?utf-8?Q?j3+nSvRgp+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FuYmJGV1RDNzU4UFdJelRQWFU0SzhEY09RSlFsTjUrTnM5TmhwZkNBLytE?=
 =?utf-8?B?L3JnbU5weUdnYWdFdUEySXp6eURsajBGd2VIaGpwNVBTVFdWWU90ZnBtMEQ2?=
 =?utf-8?B?Njd6ZmJMbVNUbEpXd2dzVUVqM0xnb0ZIS3BGamIrek9TQys0VlgrUldGYzJL?=
 =?utf-8?B?R0Z2WFgvVHE5eW96azYwYW4xWXFZRGJnTExsZU1VQmFyM2NSN1BNVnZyeFhw?=
 =?utf-8?B?SlNlT2s3dXc0c0RwbkNFRkJoblV2bnBOYTFaNmFFQ2lUZk85TFBVd2pFK1Bw?=
 =?utf-8?B?czFJQ3h1Z2N3SEtKcnZHdWNKRWdDcXo2UUNCWHNVZEp6Zkd0NFBXZGZkbWlS?=
 =?utf-8?B?OFFkbitKMFlJSnYzQmRTNk43NXZqOEROcXZMd2lmOTVlWXNTYlpxQ3I1bTVY?=
 =?utf-8?B?OHJsU29WSE5VdnY4aXFXR0gvd2ZJS2pYQnMyaElzSytGSlZ5YVEzckVCcWVa?=
 =?utf-8?B?UGZYcytYSldCU01mM3Mxa05NaVdPVEhTRGw5d2tBV2toaGhybXVCbTJKbHMr?=
 =?utf-8?B?WnJaNEQ0UU9ESjdqbjRvdTM5RUU0ZUpnNXkwenRheFNlTW9kaUxuWFhBUlU5?=
 =?utf-8?B?WERGT1VPM2F2dDh6cnhJUzVNcVBSeG9FaXoxMkZheFNDVnJ5TUpzSXNpSGpY?=
 =?utf-8?B?L0ZQMjJIQlhDczY3aEdSRHJ2eUl4S2pDSWtrMlQra0VySjBvSmtqR2ZZOTJK?=
 =?utf-8?B?dStWVG9BeUNrajhkNDV1S3p4Yk9WT3hPSWtnTnhwZkVvZW5MRHJKWTFZeWZB?=
 =?utf-8?B?b08weEhVbkVjaU1PQ0puYkJsOEgzRDRHbUxtTDd3bWNDVUx0R2Z5eGJ1WmM5?=
 =?utf-8?B?ZWNnakdCc2c1V3gyRmYzcnEzYmQ1V3JHeThzZUNvTWtGNUllek1qRWVwblJ0?=
 =?utf-8?B?RkxScWVjK0RHNk9WdXNnZ2hRcXdWdWk4TkZtS0lQcGxOZ2hIcytlRGxFN2I0?=
 =?utf-8?B?WGhWSDA4T2tVQm5QSThTNnJXWFMvaGxpNXhFRUl5SWw2UTVSa0NVb29XWkhJ?=
 =?utf-8?B?YVpxMmIwWmUzaHBPOTBYbEg4aUxlRXBKMkc1dXBDVC9ZNitRQXU4d2FKM2Ji?=
 =?utf-8?B?bEp5TVdvTFRWejhaSm5oU2N4S0ZKY0xKSllCM0J4UFE3Z3VnTmJ1Q1N5TU83?=
 =?utf-8?B?QXcwNHBEbXA1VG8xcS82NmNIb25jN01FWXgrdFMwYjg1SDBzK2lGdDBxL3Vo?=
 =?utf-8?B?RUVNelYrcWdFcmhJQ0VJVFgvbUVnK0NOeDZwSEZ5aTJ1bm9KblVwajdMcnoy?=
 =?utf-8?B?Slo1K2J3NUEzNEpOa0JmY2NCWmFVSktXV3VvaW0rTGR6ZVdnMXlac2tzUFJz?=
 =?utf-8?B?SnIrSnI1RDNQYUFscGU3RjlzbUR4cDUxeVBhb3VIeGJJWHU1Y000dWhzWHZi?=
 =?utf-8?B?REtUN3prN1ZxZm9HbDBROGxvUnJ1NXpFVGhmUnpDRmxiZUd1Rm10cEJ6c2Zr?=
 =?utf-8?B?M21EU3FMRUFKUU5OUmh6cEZoNWFhRW1uM3Rrb0xSMW9uSFprMlBjTjc5TWFS?=
 =?utf-8?B?a3kwVDlKSUF5ZzlIRDRaM2s4RHhTY2NtSGVKWGhJWFlnS2xab1BMSXpNektY?=
 =?utf-8?B?QStUOVdxWU9aZ1MwdCtITlBSRGtRb3JXdU84RHZxTW9QVjkwNTdKU2RweTVr?=
 =?utf-8?B?RFA4ODJ6ZjhUeUIwMXhZUFNia1huSEtpNzhDaXUzV0J0YWZPS3RnU0pvaHpv?=
 =?utf-8?B?VWFvbEtsYmdtYmY5SWhjVGZtak95SG00cUlWZ1Z3UkhPNDIySGlBZEtQZTZ3?=
 =?utf-8?B?N3dXSytiSmRQbnYyWEgxeTI3VXJuemFLZGZWaElBY3JxVlVYWFg3ZlZubmZu?=
 =?utf-8?B?dDZwQzFFZExPY09haUhiOTZZOG1VMVVUMTJFdjNsZ0lHTWZycXJLcnpUMnhu?=
 =?utf-8?B?Tkp0UmJtMGIzWlIxbmlSUk5mYnJUQ0cxbkR2VCtJNXk5NzJaVW9Dc3BzMTR2?=
 =?utf-8?B?Vy93Rmo5cmJ0MVl1WEhQaXAxcjlic3Noc1RHMTBYMUtoYmhKVjFRcXhWVi9V?=
 =?utf-8?B?RkgxUi9XU3duTFdOSWswR0JBS2cvVlBqbzk1ekFUUGwwK2pZQWVhR1dGQzhi?=
 =?utf-8?B?VG9rU1VIN2l1anlWWkJSTnBmd1hZcG5Qd3ZFcXJ4TXppQVF2OFVmZ3lMV2M0?=
 =?utf-8?Q?I0hJ588/LVUiG8wV/dRAHV8Es?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a38629-6197-44cd-7487-08ddbd3b2c74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:46:40.4500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sdDAyWfnGjF25TavmDnvt7cHlOvdtKt8vLmiH15Yh+N88WGiNaFMovO6anA5h8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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



On 7/5/25 22:57, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> In cmd/fpga.c, change some `debug` calls to `log_err` for important
> user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due to
> its long output which hides the actual, useful return message. Change
> the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
> __func__ strings as log_* has this covered.
> 
> For `do_fpga_loads`, move up the `do_fpga_check_params` call for more
> consistent command output; use a constant instead of multiple '5' use.
> 
> In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects this
> confusing/wrong statement.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>   cmd/fpga.c              | 99 +++++++++++++++++++++--------------------
>   drivers/fpga/zynqmppl.c |  4 +-
>   drivers/fpga/zynqpl.c   |  4 +-
>   3 files changed, 54 insertions(+), 53 deletions(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 9dc7b63db5d..9cc51f04698 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -28,7 +28,7 @@ static long do_fpga_get_device(char *arg)
>   	if (dev == FPGA_INVALID_DEVICE && arg)
>   		dev = simple_strtol(arg, NULL, 16);
>   
> -	debug("%s: device = %ld\n", __func__, dev);
> +	log_debug("device = %ld\n", dev);
>   
>   	return dev;
>   }
> @@ -40,26 +40,26 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>   	size_t local_data_size;
>   	long local_fpga_data;
>   
> -	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
> +	log_debug("%d, %d\n", argc, cmdtp->maxargs);
>   
>   	if (argc != cmdtp->maxargs) {
> -		debug("fpga: incorrect parameters passed\n");
> -		return CMD_RET_USAGE;
> +		log_err("Incorrect number of parameters passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	*dev = do_fpga_get_device(argv[0]);
>   
>   	local_fpga_data = simple_strtol(argv[1], NULL, 16);
>   	if (!local_fpga_data) {
> -		debug("fpga: zero fpga_data address\n");
> -		return CMD_RET_USAGE;
> +		log_err("Zero fpga_data address\n");
> +		return CMD_RET_FAILURE;
>   	}
>   	*fpga_data = local_fpga_data;
>   
>   	local_data_size = hextoul(argv[2], NULL);
>   	if (!local_data_size) {
> -		debug("fpga: zero size\n");
> -		return CMD_RET_USAGE;
> +		log_err("Zero size\n");
> +		return CMD_RET_FAILURE;
>   	}
>   	*data_size = local_data_size;
>   
> @@ -70,51 +70,52 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>   static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
>   			 char *const argv[])
>   {
> +	struct fpga_secure_info fpga_sec_info;
> +	const int pos_userkey = 5;
>   	size_t data_size = 0;
>   	long fpga_data, dev;
>   	int ret;
> -	struct fpga_secure_info fpga_sec_info;
>   
>   	memset(&fpga_sec_info, 0, sizeof(fpga_sec_info));
>   
> -	if (argc < 5) {
> -		debug("fpga: incorrect parameters passed\n");
> -		return CMD_RET_USAGE;
> +	if (argc < pos_userkey) {
> +		log_err("Too few parameters passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
> -	if (argc == 6)
> +	if (argc == pos_userkey + 1)
>   		fpga_sec_info.userkey_addr = (u8 *)(uintptr_t)
> -					      simple_strtoull(argv[5],
> +					      simple_strtoull(argv[pos_userkey],
>   							      NULL, 16);
>   	else
>   		/*
>   		 * If 6th parameter is not passed then do_fpga_check_params
>   		 * will get 5 instead of expected 6 which means that function
> -		 * return CMD_RET_USAGE. Increase number of params +1 to pass
> +		 * return CMD_RET_FAILURE. Increase number of params +1 to pass
>   		 * this.
>   		 */
>   		argc++;
>   
> +	ret = do_fpga_check_params(&dev, &fpga_data, &data_size,
> +				   cmdtp, argc, argv);
> +	if (ret)
> +		return ret;
> +
>   	fpga_sec_info.encflag = (u8)hextoul(argv[4], NULL);
>   	fpga_sec_info.authflag = (u8)hextoul(argv[3], NULL);
>   
>   	if (fpga_sec_info.authflag >= FPGA_NO_ENC_OR_NO_AUTH &&
>   	    fpga_sec_info.encflag >= FPGA_NO_ENC_OR_NO_AUTH) {
> -		debug("fpga: Use <fpga load> for NonSecure bitstream\n");
> -		return CMD_RET_USAGE;
> +		log_err("Use <fpga load> for NonSecure bitstream\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	if (fpga_sec_info.encflag == FPGA_ENC_USR_KEY &&
>   	    !fpga_sec_info.userkey_addr) {
> -		debug("fpga: User key not provided\n");
> -		return CMD_RET_USAGE;
> +		log_err("User key not provided\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
> -	ret = do_fpga_check_params(&dev, &fpga_data, &data_size,
> -				   cmdtp, argc, argv);
> -	if (ret)
> -		return ret;
> -
>   	return fpga_loads(dev, (void *)fpga_data, data_size, &fpga_sec_info);
>   }
>   #endif
> @@ -245,23 +246,23 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   	ulong dev = do_fpga_get_device(argv[0]);
>   	char *datastr = env_get("fpgadata");
>   
> -	debug("fpga: argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
> +	log_debug("argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
>   
>   	if (dev == FPGA_INVALID_DEVICE) {
> -		debug("fpga: Invalid fpga device\n");
> -		return CMD_RET_USAGE;
> +		log_err("Invalid fpga device\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	if (argc == 0 && !datastr) {
> -		debug("fpga: No datastr passed\n");
> -		return CMD_RET_USAGE;
> +		log_err("No datastr passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	if (argc == 2) {
>   		datastr = argv[1];
> -		debug("fpga: Full command with two args\n");
> +		log_debug("Full command with two args\n");
>   	} else if (argc == 1 && !datastr) {
> -		debug("fpga: Dev is setup - fpgadata passed\n");
> +		log_debug("Dev is setup - fpgadata passed\n");
>   		datastr = argv[0];
>   	}
>   
> @@ -269,20 +270,20 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   	if (fit_parse_subimage(datastr, (ulong)fpga_data,
>   			       &fit_addr, &fit_uname)) {
>   		fpga_data = (void *)fit_addr;
> -		debug("*  fpga: subimage '%s' from FIT image ",
> -		      fit_uname);
> -		debug("at 0x%08lx\n", fit_addr);
> +		log_debug("*  fpga: subimage '%s' from FIT image ",
> +			  fit_uname);
> +		log_debug("at 0x%08lx\n", fit_addr);
>   	} else
>   #endif
>   	{
>   		fpga_data = (void *)hextoul(datastr, NULL);
> -		debug("*  fpga: cmdline image address = 0x%08lx\n",
> -		      (ulong)fpga_data);
> +		log_debug("*  fpga: cmdline image address = 0x%08lx\n",
> +			  (ulong)fpga_data);
>   	}
> -	debug("%s: fpga_data = 0x%lx\n", __func__, (ulong)fpga_data);
> +	log_debug("fpga_data = 0x%lx\n", (ulong)fpga_data);
>   	if (!fpga_data) {
> -		puts("Zero fpga_data address\n");
> -		return CMD_RET_USAGE;
> +		log_err("Zero fpga_data address\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	switch (genimg_get_format(fpga_data)) {
> @@ -303,13 +304,13 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   
>   			if (gunzip((void *)data, ~0UL, (void *)image_buf,
>   				   &image_size) != 0) {
> -				puts("GUNZIP: error\n");
> +				log_err("Gunzip error\n");
>   				return CMD_RET_FAILURE;
>   			}
>   			data_size = image_size;
>   #else
> -			puts("Gunzip image is not supported\n");
> -			return 1;
> +			log_err("Gunzip image is not supported\n");
> +			return CMD_RET_FAILURE;
>   #endif
>   		} else {
>   			data = (ulong)image_get_data(hdr);
> @@ -327,12 +328,12 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   		const void *fit_data;
>   
>   		if (!fit_uname) {
> -			puts("No FIT subimage unit name\n");
> +			log_err("No FIT subimage unit name\n");
>   			return CMD_RET_FAILURE;
>   		}
>   
>   		if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
> -			puts("Bad FIT image format\n");
> +			log_err("Bad FIT image format\n");
>   			return CMD_RET_FAILURE;
>   		}
>   
> @@ -348,7 +349,7 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
>   	}
>   #endif
>   	default:
> -		puts("** Unknown image type\n");
> +		log_err("Unknown image type\n");
>   		return CMD_RET_FAILURE;
>   	}
>   }
> @@ -390,16 +391,16 @@ static int do_fpga_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
>   	fpga_cmd = find_cmd_tbl(argv[1], fpga_commands,
>   				ARRAY_SIZE(fpga_commands));
>   	if (!fpga_cmd) {
> -		debug("fpga: non existing command\n");
> -		return CMD_RET_USAGE;
> +		log_err("Non existing command\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	argc -= 2;
>   	argv += 2;
>   
>   	if (argc > fpga_cmd->maxargs) {
> -		debug("fpga: more parameters passed\n");
> -		return CMD_RET_USAGE;
> +		log_err("Too many parameters passed\n");
> +		return CMD_RET_FAILURE;
>   	}
>   
>   	ret = fpga_cmd->cmd(fpga_cmd, flag, argc, argv);
> diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
> index 2b62bbbe3cf..1199b249e36 100644
> --- a/drivers/fpga/zynqmppl.c
> +++ b/drivers/fpga/zynqmppl.c
> @@ -191,8 +191,8 @@ static int zynqmp_validate_bitstream(xilinx_desc *desc, const void *buf,
>   	}
>   
>   	if ((ulong)buf < SZ_1M) {
> -		printf("%s: Bitstream has to be placed up to 1MB (%px)\n",
> -		       __func__, buf);
> +		log_err("Bitstream has to be placed above 1MB (%px)\n",
> +			buf);
>   		return FPGA_FAIL;
>   	}
>   
> diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
> index 3e86d854a01..a8ca015a8a6 100644
> --- a/drivers/fpga/zynqpl.c
> +++ b/drivers/fpga/zynqpl.c
> @@ -360,8 +360,8 @@ static int zynq_validate_bitstream(xilinx_desc *desc, const void *buf,
>   	}
>   
>   	if ((u32)buf < SZ_1M) {
> -		printf("%s: Bitstream has to be placed up to 1MB (%x)\n",
> -		       __func__, (u32)buf);
> +		log_err("Bitstream has to be placed above 1MB (%px)\n",
> +			(u32)buf);
>   		return FPGA_FAIL;
>   	}
>   

it is not 1:1 conversion which generates this error

In file included from drivers/fpga/zynqpl.c:12:
drivers/fpga/zynqpl.c: In function 'zynq_validate_bitstream':
drivers/fpga/zynqpl.c:363:25: warning: format '%p' expects argument of type 
'void *', but argument 2 has type 'unsigned int' [-Wformat=]
   363 |                 log_err("Bitstream has to be placed above 1MB (%px)\n",
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   364 |                         (u32)buf);
       |                         ~~~~~~~~
       |                         |
       |                         unsigned int
include/log.h:234:24: note: in definition of macro 'log'
   234 |                 printf(_fmt, ##_args); \
       |                        ^~~~
drivers/fpga/zynqpl.c:363:17: note: in expansion of macro 'log_err'
   363 |                 log_err("Bitstream has to be placed above 1MB (%px)\n",
       |                 ^~~~~~~
drivers/fpga/zynqpl.c:363:65: note: format string is defined here
   363 |                 log_err("Bitstream has to be placed above 1MB (%px)\n",
       |                                                                ~^
       |                                                                 |
       |                                                                 void *
       |                                                                %d
   CC      boot/image-fdt.o
   CC      drivers/core/device-remove.o


M
