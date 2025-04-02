Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251AAC36014
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 09:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097C180FDA;
	Wed,  2 Apr 2025 11:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V0JxNvD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7D881CF0; Wed,  2 Apr 2025 11:39:07 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95D880584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 11:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw8ipfjAo6ffaPGJ6aRjacrvcQGSHobC1IO0foCuQNgfaJ5l/AfG8o1/ZEbxz18AcQFsmm3/ZUnmtBasBhkYNCbOgCJW4DfrHemyKudVLryJ36U4JMFhlMyohTS7cAo0aXi+wXM9GvtAPf+fIq72yDxj2azyk1ARQAu/WwpLlpz5UjKNsVFlYUyjdM30873lXl1eO5/OJ1D7/KqIMRW5qhVGlI5mafWjBIJdpZfmsWJ1PKLpua70Vi+XTrscIAjb2bfaxNMdMaev3dmMmys9ek+vDiSeK72og84xcIQHRBWB6fhKmhZy4cVb0OYv/aB5FBlTrdjrHAHqQslK37ht4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVkUctjAzj9JUNAhnTaDHWqoi+pn7dLRZM7R8CU9zSk=;
 b=x/jrWcoaIeJ3sDJGjTroXt4HZJ69uA6uZfPqhATPFud9m0taxzsCnHMUCDxjTJbu4YSCgv2hu2Ph5zs/pxezM+wDKIXcCqKjElzgJQJX9cYrboWvVt6hqjhzpxLf1PRAfygwC+qbW0uPcAlJcdMtrnap3ZWbMsYxJuiWr7HdCnvyvz/5QZhkxSaD74jHa6eZ3X2397jMJlDuyRG5M0esgA/qi/kfs3CVwOMZQY3+XjK+PbVt70ROomWsdvc6O5QzhymmXrnyLO9+nB+2fHPOC/Xr44qXXG7YkvTlWsDh3OqQl3L7TBYmQ9cLcUesSBelfSN+OFCqZktbCEt6bAccXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVkUctjAzj9JUNAhnTaDHWqoi+pn7dLRZM7R8CU9zSk=;
 b=V0JxNvD2+88WBSyN86E2lzclssPuq16Vgt1kusC7AEm+pv9aL2f6YcfkuFOoB7n6oMk5QCzulqgQiF45A5ZAGhaRmTyijxXfkp9WFgiNV0EiGoC9dPiCHernKI3iAL1YxLwQYHt6FoxcsFfSsOqrhrVOq/IbfzOsKkM/42ToF+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 09:39:02 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 09:38:59 +0000
Message-ID: <653ba504-a94a-4569-9c4e-016fe6ff4771@cherry.de>
Date: Wed, 2 Apr 2025 11:38:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Upstreaming Orange Pi RV2 vendor patches - Seeking guidance
To: Sungjoon Moon <sumoon@seoulsaram.org>, u-boot@lists.denx.de
References: <09c3ffd2-3933-4a3b-b64f-5cc10a1942fd@seoulsaram.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <09c3ffd2-3933-4a3b-b64f-5cc10a1942fd@seoulsaram.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10416:EE_
X-MS-Office365-Filtering-Correlation-Id: d850b32f-7bf5-4209-2aed-08dd71ca2a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmE3YTdxWUxTWDRtNWVDdWJuQkZROEU0SU1MYkZjYXpFdHJtdlhyeEY4c0JI?=
 =?utf-8?B?OWlYeDlUY3lEeXpKbHd4eDFWc25FeXk2UCtWWDNWYXlEL0RsdG1CeWlRQ1B4?=
 =?utf-8?B?RkhXNnlKRGNYaGtwWDRqSkJZZ3gxSXF5Y2pueUF6THBpZ1ZUbDQ0dkpiVEpC?=
 =?utf-8?B?OVhTc28vbDc1Yk1kSzdVRzgweTcvSGpJelhFRGFlamFKenY0NFkvZ3BoOTV6?=
 =?utf-8?B?akxIVjJmb2FlYlRoZGlnQWR6TWl0Y0lTT1RQK0JOQlUxdTF6MVQvcnRPMVZ2?=
 =?utf-8?B?c1NhZHVLWWYvWmlGVjVENEdBSWxJOTBWejBMaFdmUWZkaTMxd0oyUkczTDBy?=
 =?utf-8?B?S2NBbHdZOWMxTGZ6WVE5Y1pVQTc0RzNVZldacDBoTGhmWDhEdFhYcDgxZHh1?=
 =?utf-8?B?dmlZdUJ5cENCeVRPdk55Uzh2OThGSXB4R3duS3AyNWVCdGJIR0ZvYU9NemJx?=
 =?utf-8?B?b3FibVRzMW5NRndIN2JZSUdpS01odTFORkxLQ2lnVStKRUVyMHJSei85RUtp?=
 =?utf-8?B?WnVMNHRCNlhjMGxIcVNpRWF3RmhIQU5jV3pINjlDTis3YzVyU3FLaXFxNkJq?=
 =?utf-8?B?NGpHMG1sKzFFZ01ZbEY5TE4xRDUyQWNKT2luNHNxQXZyV1pabVQxVUQvRExW?=
 =?utf-8?B?d1lWbUcwMy9TdmU3WSt1K0tFTmtOaUp0WmQ0WXZURmdNd01aSURsdkc0OUl1?=
 =?utf-8?B?eEZET1ZnVUJSVjZoOVR0NlZTbU1UQ3dVYnpsbWVTV1RjVzFGT1d5M2R3V3FP?=
 =?utf-8?B?NWF1eW5uek1ZN3hJS3JsbGxLUnh0QUZFVFNMMHcrYWdRWERjU3ZBUDNVRDNx?=
 =?utf-8?B?YTZvekdxaGp6bU96a3dWNjk1SmVIbFlMcWJPK1BOQWlqU3VzRUc3RWwzUW1n?=
 =?utf-8?B?bFR4RGs0ZHBGOWx3Z0hpbkMxUnNoU3VEQ3JhM0N2QWh5amFCanQvbk04cWlk?=
 =?utf-8?B?Uk9mS25ZUXRYKzYzL3BTYklxOGFJalRlTmlWVnh3TXVaVzdKOTYwaDMzWFl6?=
 =?utf-8?B?OVppaE5BenVScldxRmNUdHBmaXpRWHpscW1MZEpxd090Ym9tTkFyOVEyZmpF?=
 =?utf-8?B?MytNTm5BRjRqVTBsMVBUQThBbUVxTnFJdXJHbG1oc0JjUkxtWkZTNWRkZC9M?=
 =?utf-8?B?UDh1SVlEL09VUlozMXJMOC9BbDAzbythcFVUcHZSZGk4cEViakMzQXcyM3V5?=
 =?utf-8?B?b3BNOEJyeXhyMkhzQTkxRVZ2TVFVS0F5QmYwVE1NZGs2WTJEK0tDWlNkekpB?=
 =?utf-8?B?UEtLTGs1VThFSEsrU2VDN0UwWFZKa3lQZDN4bDV2RVR3a3RVYWhZUnJUd2Fm?=
 =?utf-8?B?WEwweSsxWlN5N2pBTkZuY0pNdHBUOGQxS3pSTG16c1FwWmV1aWd6REJFNy95?=
 =?utf-8?B?LytzckxnS2FkUHFFUU96dmZnOHc3dTlVSC9zZXZucUZld3RjcnZpcGRyRkVY?=
 =?utf-8?B?SStYUk42VFc5NVFqcGJXTzNlVC9BR24rS204K3pFWGpaQ3BkeHJMUGlBN0pr?=
 =?utf-8?B?eTdMb01CaXNVeEZ5azM3VmpabWpWaE1LUldjeFV6NytZR1Y5NWtxb041ZFZr?=
 =?utf-8?B?NEFSRjdnaXkrcFhxUHlNaVBSa3NRdysyYzNjSTVFOVVPcFpFQm5LaHljMjFC?=
 =?utf-8?B?c1VUQlNvTnhjakZVMHcyVlhOUjlhdVlFM2hxb2o1ZFp0K2o4V01NRFJUZE1z?=
 =?utf-8?B?OVBHU2w5K1g5UHJaRUdNVHdHT2ZqRmhrNDEzUlBHNW5SU3l0TUJIRDdCN3o0?=
 =?utf-8?Q?tLIN9X0shl1T1kc6Wbdmx3L+5NnTA8swmywAm5j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEE3TytKSkdTT1BvdkFHMGZVYVMvQjFybFZrKzN0SmNTajk1MXZmVlN6RUZH?=
 =?utf-8?B?Vmo0alVLNTh6MzRJZHFkZkNCbDhzMWttOGovNjNPZ1hxbStnNkhZTkZSMUky?=
 =?utf-8?B?bFpRU2J5N1BUaHJTUUJGcUFyVVluNGFtV1RyVUpQQnRjTndJTG84Y3pjV3ZQ?=
 =?utf-8?B?bU1EUmNLd2hQTVNQNGJKTEpBUVV0MytzamlSRlFqRGNsYk5HVi9RSXNReHZp?=
 =?utf-8?B?SENIR1ZnS1NaK0N5ZCsyK3BOa1pBS2ZCUTBQZ2JkeGFGaTBDUjNlSWJGU3lJ?=
 =?utf-8?B?dWRENjRxV2ZyZHFmeStnMWkxUTBRRklqcmoya2ZPQm53ckE1QWVUa2JYVVps?=
 =?utf-8?B?aERrN012TlRpUjMxQ2FCSXF2N0JtTUl4YkRXVUMvang4K2U3ODBiT2h3R1Zs?=
 =?utf-8?B?dzJpRlFLQkREcHRrZTREQ0ZLRk5uNHg0VUt1N0wwdVRYTlEyRHpUTjQ1WWg4?=
 =?utf-8?B?dzhLVU1HYVA5SU5FcDhxZ3lGVGNLUlN6OUtUcnRXbUxndTRkTVlwY0FzRWVX?=
 =?utf-8?B?aUdnS1FqelFVN0ZDWFdSRzhRUk5DMnk3clIxM0kxWkJoUWlwQ2RDaG1ZanNP?=
 =?utf-8?B?aVZ2Y3pFc1gweHk3enBjK2dLSDhxQzlkYVdQVGtTZmNMQWpQN0ZUdDFhQUk3?=
 =?utf-8?B?Z3BxWEl1T2oyc1BZSzlrV2NMQWlFazdLK0t1NCtuWk5tUW43WUt3RGtCSm1W?=
 =?utf-8?B?d1A0MHRORHRZcHk2Ym9MMXdraUFCR1lWU0VvNkljeHArVEJZZTBWRkJSS3pS?=
 =?utf-8?B?ejc0UlQ4ekxzdWdqWm5NWndTZWdwRUlwS2hmZ0JLcUF0QUpCQTNodU9uanlM?=
 =?utf-8?B?T1BId2dwTlNIRDkvc3JJQ1l2cUNGZGdqZUlLaURLWEE1WE9mdkUzQmMxTWJC?=
 =?utf-8?B?SnlzOFNWajJza0UvSjhVU2ZsSWNLSmtMWVhHQUh5R01DRDJ6WnlEdFpocGZh?=
 =?utf-8?B?VHRyR0lIREdYTnNmcWV3OHRJNVlvNHhiQVpzdEtWeThoYTN4N3FwRFlVMXpz?=
 =?utf-8?B?MVNnbHlaNjFvSzRDQXBUajhicFFxTDhWa1QrY3lFMXl2SXBYdFZ4TWZDalBF?=
 =?utf-8?B?a3JwZXQrb2RMLytvT1ZpNFVSdzJXYXBjZWMrWnc1azl4QmFFM1ZLKzRZMUVO?=
 =?utf-8?B?cjYrVnlRa1J4ODJzQ1NSZ1ZGbUU3a2V4c0NMQUNXdUFHWmZtdUVhV2tRRERo?=
 =?utf-8?B?Y3p3bDYydGEyTjVVTWNZVDFSc3pNSnhJaHBYc1VaNDJiNlYvYnAya25Ua3Jk?=
 =?utf-8?B?OGNVb04yNUVrVHFzV3d4UUZFcVVhY2ZTa1NnckFHaUp2UnhCSGJnWVFRZExu?=
 =?utf-8?B?YnZiMDJGRU1RbUU3WDBCY3hUZXUwWE1EdG1PYkd1L2NsTmhWMzNVaFR1c2xu?=
 =?utf-8?B?Yll3VlY1WTk1aC81VGxzZ2pHM21PMXp2cld0NGFYTi9lSkQ3dHJld0RtMHdD?=
 =?utf-8?B?VnFKMUJheTM4OHphTm1ISkxmc1piV3V5enhBUklnR2NHdkVyZHo3c3B6blB3?=
 =?utf-8?B?MHJ5UW0zQXZaa3F0amdWR0NxZVlDOUdNSTVneUZOM1U4MUdLeWFwNkR0RFRk?=
 =?utf-8?B?d3ptZldGSmhIMkl1MFJ1ajNzUDV6aGI5UExwSElSVm02UFIxTlowRnI1STZG?=
 =?utf-8?B?RkJUbk5OdEFvSmVGR2ErWm00SXBWSDd5aU5xNEJpbkhnWkUyM1VvMjVIN3E3?=
 =?utf-8?B?djRtVk01dEVtWE9SVUdDQm9mWG02Y2VOQ2lzZkNDU1JrYXFjYkVtWkY0dFhH?=
 =?utf-8?B?RjZMMU9RaitpWlJGSUhnOUN1NEVFSDNMWkh3TVFPWkZxMmhkSFhDM1o1dmFk?=
 =?utf-8?B?MXA0Mk5NbzhNbm85YUo0M205UGtGcEJESlJFRUxKM3F4Rk9EUGkzV0hUVDgx?=
 =?utf-8?B?VFFzMUJDVVpTTVVZYVRqSzMyQk5QU3NIVjlsaTBGakF4aEhEa1FQQmNhNk5a?=
 =?utf-8?B?RWRMaFJXcGVsckRINitSZzlBUEoreFJBTXdpVG5uTTBJVS9pMEhvRlVCSElt?=
 =?utf-8?B?N0xPeThsSWt5NnJldHBGQkxxdFhJRGk4NEd5UFl3RlRPS2srLzVGL1ZoM1hO?=
 =?utf-8?B?WTNzN1kvcU9yM3RJQVdZa2lyK3ZPRG9OZlIxS056TWUrNldranJBVzFiaEc5?=
 =?utf-8?B?dWJyVUFRb201Q2JIYVk3dXJrWm9uWEw0ai9sYXEwcXd1ajZTNG9iZC9zSmxB?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d850b32f-7bf5-4209-2aed-08dd71ca2a67
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:38:59.5397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqQEdthJILl5Jd0Ch5p4HFyEqjY1wz5EQhO7YJvHsQjlHnPG2I4kQqijkNbh88+zmuLwo+SrhJ0Za4JhaszhiJ1kfJOsgOTV5J9aTj+5NHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416
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

Hi Sungjoon Moon,

On 4/1/25 3:41 PM, Sungjoon Moon wrote:
> [You don't often get email from sumoon@seoulsaram.org. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> I'm working on upstreaming vendor patches for the Orange Pi RV2 board, 
> currently available at:
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2FOctopusET%2Fu-boot- 
> orangepi%2Fpull%2F1%2Fcommits&data=05%7C02%7Cquentin.schulz%40cherry.de%7C32ac8a27848840e80f4f08dd71657036%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638791402679712024%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=VhrD%2BgKD0cCW5pZIKhy7BoiGtj5fyTKukkdVj116jIY%3D&reserved=0
> 
> I'm rebasing these patches onto the latest U-Boot branch (v2025.04-rc5).
> To ensure the patches meet upstream standards, I have a few questions:
>   1. What specific steps should I take after rebasing to prepare these 
> patches for upstream submission?

Not sure what exactly you're after here.

You need at the very least to run scripts/checkpatch.pl on all your 
patches and have them pass successfully. Some warnings may be ignored in 
some corner cases so ask if some warnings are odd or difficult to fix.

This can be run automatically if you're using b4[1] with `b4 prep --check`.

Your patches shouldn't break other boards, be it build time or runtime. 
For build time, you could build everything and check that it still 
compiles. I vaguely remember buildman tool is supposed to be able to do 
that but I've used it maybe once.

>   2. The current patch set is quite large. Should I split it into 
> smaller, more focused patches? If so, what would be the recommended 
> approach for splitting?

https://docs.u-boot.org/en/latest/develop/sending_patches.html the whole 
page is worth reading but to answer this question specifically:

"""
- Patches should always contain exactly one complete logical change, i.e.
   - Changes that contain different, unrelated modifications shall be 
submitted as separate patches, one patch per changeset.
   - If one logical set of modifications affects or creates several 
files, all these changes shall be submitted in a single patch.

- Non-functional changes, i.e. whitespace and reformatting changes, 
should be done in separate patches marked as cosmetic. This separation 
of functional and cosmetic changes greatly facilitates the review process.
"""

I'm of the opinion that it's easier to start with too many commits and 
squash them on request than splitting commits.

If there are patches that the project could benefit from that would 
impact more boards than the upcoming OrangePi RV2, you may consider 
sending them in a separate series in advance. In short, series are 
rarely partially merged, so if there are controversial patches in a 
series, it could be beneficial to split into multiple, easier to review 
and merge, series.

>   3. Are there any particular coding style or documentation requirements 
> I should be aware of for the Orange Pi RV2 board support?

https://docs.u-boot.org/en/latest/develop/designprinciples.html
https://docs.u-boot.org/en/latest/develop/codingstyle.html
https://docs.u-boot.org/en/latest/develop/board_best_practices.html

Add tests when adding code.

Add documentation for your board to 
https://docs.u-boot.org/en/latest/board/index.html

>   4. How should I handle any vendor-specific code that may not be 
> suitable for upstream?

We all have different opinion on what may or may not be suitable for 
upstream. Anything not sent upstream, we don't care, that's your problem 
to handle. If you send patches that are unacceptable, we'll tell you and 
we'll try to figure out ways to deal with them (easier by outright 
rejecting them, or by suggesting ways to modify the changes so they are 
acceptable).

What specifically do you have in mind as being not suitable for upstream?

>   5. Are there any maintainers or subsystem-specific mailing lists I 
> should include when submitting these patches?
> 

Use scripts/get_maintainer.pl on your patches, and Cc/To most/all people 
and mailing list listed there.

This is done automatically by b4[1] with `b4 prep --auto-to-cc`.

[1] https://b4.docs.kernel.org/en/latest/contributor/overview.html

> Any guidance or best practices for upstreaming vendor patches would be 
> greatly appreciated. Thank you for your time and assistance.
> 

Good luck, have fun and looking forward to seeing patches on the mailing 
list.

Cheers,
Quentin
