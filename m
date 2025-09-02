Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D0CCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A3B83280;
	Tue,  2 Sep 2025 10:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="e/c24Oj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A393483287; Tue,  2 Sep 2025 10:08:28 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B7DA83253
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrmxNu0KIufkUzq1qNOEN0sQfalRWeYII5iNS5T/rPYl7srk5gLCEI4cGUmFjovYOQV3ilcFvCHGfNBhQNFbtKvhMobY6DRB4tzHkqavzgaxtESqWIlYYmZCW/q6nSiIds0yjZUqrIzsv9Oe1BvAN8DsSmu/Pof3BWTBnAKAoh5DFiD3BScTVvJ51XbK6G3L6R0rQ2rmFlB7qevNp2v2hG1R2L16x3J8aytmOW5CgdNGSsVVh4B/964e3kzmTs+8M06LBK/4SOVmKlHkDRBJfY11+drSDUfZIfDNCjcnLx1nO54Y6g0jds0YT2RDOzeehxSa7RBnB4Ee34U1Eku1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfJPk3eyR1rgYgS+LOjiCnU7sTbylSvrbyPjp9An+eQ=;
 b=BSdT1pxvJ3GQ5N/TPWcV6B3uy7iIaQ3PbG//Tz5XiaLIovZ4GuU0+/jSGyTk0EDnwwgat7dM040zQlcr1ALoC5FH7WnjiYNz8G35sXpYrDZSEwts5DWzPs+cuKHCrGLwCP1Q3QDTY3Dt/IngT9dxfJATfUNuTHbLycHLbJ/2uf+oZfxlDyIICnxsb5M22oJs2PgHWrsYgZrzilhOujgfmXBdmIE4j7X8QBTyByOsqWWw5Ia/6jqgvOv/myU3TTdYv4pXK+PpJ9GKsC7wGcgfWOLYAexmZX1FakWWn4i/NXBw2yTxOIFXPzdfrls/ZU05naMguftcOYn6Y/FsCitLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfJPk3eyR1rgYgS+LOjiCnU7sTbylSvrbyPjp9An+eQ=;
 b=e/c24Oj3FPpxk9JcE9E78u7Wz1llTKPAw5iUfocEnaUYtGjaHlI03fT1KwazHwvclIIXttZpgG50yrja1ywPrB2MKVbHarH4N5pcTiSSbmrRQCsEb6ekWHQM28SgIeJwVqwesEd3L6jTJ3RmWgJmuxBUZkQJ72zdbcmyEXDwv+75M/E9IuxmVSU2HTtYGC0ALmyPc0xJMdEMeg8wFbe/01cv2NWxMQgfsafX5BhlAnOUMBApZdBOCZIGXfD5JZxaH7npBR/PtPEXqk26ZVxb68+fb68iRdGZsyFw4lwEYPNI7l95+l86lh/eKJmoq+Hr86L9O73GaG35s0d+Tba2fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by MN2PR03MB5373.namprd03.prod.outlook.com (2603:10b6:208:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:08:23 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:08:23 +0000
Message-ID: <1518ad66-f599-4b37-a615-d187209cc900@altera.com>
Date: Tue, 2 Sep 2025 13:38:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source
 selection
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
 <59b3e8d4-3a00-4ddd-a23c-332ab7ec15ae@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <59b3e8d4-3a00-4ddd-a23c-332ab7ec15ae@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|MN2PR03MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5680cc1c-066a-4215-4e63-08dde9f7e294
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0RraTRuUm1aS2kzd1RXRFhndUZiN1RwMmkzcnRCaUtYOE5JS1FyT0lKUktQ?=
 =?utf-8?B?akYzb3dYTXhOSjhmUnBETWJTaUtiM3hCaUZKYmNwSERDZWVxN0dCNXNaUmUw?=
 =?utf-8?B?bFVzSXdXdkFtNyt2VVpFaVQrWktGZWFBUVlNZnl5T3JhZElUeVcwQTErY284?=
 =?utf-8?B?UFJNK3l6c295TGI0ZmpGZWxsWEd1Tm5lSTc4aEdCL3REMHdvQ2lzWHVMUHIz?=
 =?utf-8?B?bHFmeHFYVWFxS3VDamZkNVlBZVJHNndGWmwySDhTVDFhV2lIcjdCZGtMbkpj?=
 =?utf-8?B?a24rQkZwRzdheFBkNzdhZHFBayt6UFpleWhqSnpFZk5nUGwzbWJNZnZSTzdp?=
 =?utf-8?B?QVZtOTlVTFpYVk1Ob2tDYUY1cXBvWXQrbFFCRFBkK2UxdDVYZFdSWkZGQXpM?=
 =?utf-8?B?bStML0JETXF4aVY4ZlE5L2xrRDJqVnFxenBCdVNleTV4Q0dZVjc1U3dhM3Bq?=
 =?utf-8?B?TEZwaGNGbFkxbmZQU2ovNjlJUmY1NU9uMHJ0K3A2Z3pWeFA1dU9VbDU0Z3dI?=
 =?utf-8?B?YmdNdTJYak05RzRYWXF2c3ZZQWNEaDdvV2NveXkxR0xULzN5Ymk5cVpNUFph?=
 =?utf-8?B?MW85T3Q5WFhqYmVGUG1iakl5UGVwM3ZwdDVHQXBlYlhaRDE3cHB4YXV5bTNi?=
 =?utf-8?B?ZVdNYmp1Vk1ta2hTU29rVUVscXVVS1k1SkpVTWFxaFR2Z0RjMVlsMGJNRWN5?=
 =?utf-8?B?QlhXUzJiZUlIN0JhbVN0QzdnS1Z0N3NXK2kyaGY5ZEMrZ1U3aUh6ek5VZlhw?=
 =?utf-8?B?a0QwOW1jZEplY1dZelFWQ2ZzY2dITW4xcTlXbmVBdUhkNFIxb3RsYlFucjhk?=
 =?utf-8?B?cXJDVHlEQzBkazQyekFnS1UwWnc0cklvWm53c1crWkxVelAyM3ViWHdXNERl?=
 =?utf-8?B?TTd5RDhNczRKU2dKTlVmVW16dlcxMXE1VGpmT3A2aVZLRytLMjBBeHZ4VW1H?=
 =?utf-8?B?RVJHY1Y1Rk5ENVdoWVN5aktaNDlSSFkzUldCVUtWUnVXTS9QbE1ZRnhKa2Y2?=
 =?utf-8?B?WE5UN0ZBQkpkalRlaGJjRHBkTXJyT1VQRGdqRytleEZyaExFMHBUWUcvQkFF?=
 =?utf-8?B?emZhWUdsYnBNbGhwQmRBWnNjRmpWS3NJMWJ3RUV1NCtKM1JJanR3U3N5NWZV?=
 =?utf-8?B?c0NJdTQ3QURMNGt6Y3V3SGllcVVmdXkvZEpXY3RTSmpzaloyaTF6QUk2aVZX?=
 =?utf-8?B?OUFKQy9wa3U2WGxUbDBaaFJXTitGYTcyZTMzYmtKVkRjVDZuVEcxRU1oYWFy?=
 =?utf-8?B?cDNGMXJxYjFyNk1yRFRJSHdkSlYxc1VNb1ZwbUt5blVrL0hqcDRCRm11bStN?=
 =?utf-8?B?ZXdPR2pxM3V6SkN0ZFR4YkZMbnZsd1FORVMwNGhFVjNQVlZTWS8rODcwRm9k?=
 =?utf-8?B?b1NkbzZUbWhjbEN3QjV1dEQwL1VzcCtyellYbStXWmhFbWdFa0FrNlpTdG9O?=
 =?utf-8?B?czBSTU1yeU9ZRUovWU11YUdIRm0yeUIrV3BiRUJqc3piNDVCSytVc21ZRDBq?=
 =?utf-8?B?ckVKWFRJZGQ2dDRSb1NlLzdYZFVuZkVaK1NWSXhXcVJjWkFsSHdhbnY1d3VZ?=
 =?utf-8?B?TDh2L2t4RXR3TGNRVFJJbDA4RTF1K2J0Y1NhTGlQcUFiQjg5WVo1T2x4NVNk?=
 =?utf-8?B?bGlKZG9VTjI4NXNWbFVib21wTDFIZThyWktYR3dxVENnNmREeHB5U3BTMGpm?=
 =?utf-8?B?ZVFPOGUvUENmd3BOQ0xZS3k0U096YWtNcHlqYythUmZjWS9EYStuVnEwNEZ1?=
 =?utf-8?B?TTFQNS9pWjl4MGZXaFROeVVWYS9SYi9rTi9vbU9DUkVSZG1aMlNFR2RjQlM2?=
 =?utf-8?Q?fNPG5ksezN2X0gekvB9qsBNHNj6chmqmBsYfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1Jtd3dOVlAxUDFIMXlQeG15S0lZUkZkcWtrYXkvZklzdG5iZHg4MjUyd3RX?=
 =?utf-8?B?UUdMWnRCa1lSOFdVUjQrZHhJV3VwenpMMmVvMlVURWw1S0xESEZvbXp2YjlV?=
 =?utf-8?B?dkRaWk1sS2ZTbHN6U1R1MGNZZEFrenNPNUM1MTAwZGZPRDdkdXJtOCszV1N0?=
 =?utf-8?B?ZmJTTTB0UTdpMEZxUEtMK2VtUXUramE5VlNUWkxWVmE1b25CTXBIbnJYZURU?=
 =?utf-8?B?U3VoQXhrVU0wMWxTeXRmMlhCb0QrVGZ0aFhGWE5EbG1JTXBNN1FpcS96SVA5?=
 =?utf-8?B?bmIzVHVtMTdIRHJoc0FkTzNFK3ZOMUlYNExieUhPb0xWTTE4eFY3TG5qYldT?=
 =?utf-8?B?MFRaUEt4aG5Td0R2WmxlZkNtQUZoZFNSWGxFcUg0OG13VEhDK3FmR2lxWG1v?=
 =?utf-8?B?SEZMOHRnNjJrcGRIWHYvN0NacWd1RE1VTTdmRzBUd0UxSnVNa0tPMXZiM0JU?=
 =?utf-8?B?emlOZ0JHNDFEQVo5TzdCN2JHR3JaZVpHTDZWT24vdVMxa1hrbzdDZnBxOGRo?=
 =?utf-8?B?T1FpQnBpcGpkVDh4TUJpVHZhajBuTWpTdXgvKzR4R0g4R3ZDRDdoczJobW9q?=
 =?utf-8?B?QU1TNWZCclA3Q1k5QmpBWkd3TkJzbjQvNWh3N0RhTjJmdlkxMmcyeExtOWJS?=
 =?utf-8?B?WUs0M01JWk56ZWRDZnRtL0l0VmFUdXo3dWRoTmpQNUZRNzJKbTVzbDZ0OG5r?=
 =?utf-8?B?cFMvUG4yS2lRc2htM3llME1lbHd0eEpZTmgrcGYvb09kdTJITkFDNnVwY1U5?=
 =?utf-8?B?bUQvSEZYemYwcW11TzRzQWhpaDNaMVY4c09Vc093bjZna3FYLzhUaHpocFF4?=
 =?utf-8?B?OFVoZ0tEMG1leHg5YlNxUUczdWVFamNIa2ZTUkYvdDh2VU9FdEU3SjU4N2FB?=
 =?utf-8?B?eFJsS0VyVitDVEd0a2hMNU9TTG1FdHlmbEwxZG80cklqWU44c1pYSGVJYzUw?=
 =?utf-8?B?ampMaFh0amRBM1Y5bHpNV0Q3Umo3N0xobldiVmZVN1pyanR6Q3JmMTk2WHV2?=
 =?utf-8?B?QzhWWmk2bmFvQk5HK2VZMnFxbkZIV0NEbHhiSk5QekZMUnFTaEF6VzlEOXFz?=
 =?utf-8?B?Zm5mdC9ybUdQWVhDOXJkUjdxZWJUd3RZdVlReS9HeWdVMzViSmJUYU11MHox?=
 =?utf-8?B?WDhEMGEvT3BWUC9qdU8vWEVoRXJqb3oxdWI1ZEpwdklnalNmTHAyMlVPYmxS?=
 =?utf-8?B?dmU5Tm8zemVDZStHL1RlSVBhM1NBTXl2OEpSTlJPNitncSs1elBrelk4THpJ?=
 =?utf-8?B?aUsvZG9KeitHRks4SkJ0ZDJhOVYzUFhWL0xOeFVPV2hIQmp2blJIMFZGclQz?=
 =?utf-8?B?b2dZMmJMSG85UjN5cE5kdlE2SVhwN0Jnb25TMnFMUGRTRGVScnduTWdhTy8w?=
 =?utf-8?B?YjN2T0FaQ3lBU0NlTnFwTWhqZlhtbXd3aGhHczlIcytkenJzemcyTTQ4U1ly?=
 =?utf-8?B?Y0tYa0t1ZUhWK0taN0lyb2VUZ2ZTbk41dThFMnNVaURscTVOWGhLazVlek82?=
 =?utf-8?B?bk1LTVBWbkxMdkgraCtVL0gzVXRtZ1JyczRXWTV1WUZTanJuQjVvK3BQdDE5?=
 =?utf-8?B?cEpsU3lHcXcvUjRTdW8vSHU2OWFHVHpaakZyeXRQOVBIUjloVUhNNytDbWxn?=
 =?utf-8?B?K2p4YjFBN1RhdVFZT1VrZmtUS1dZSVhFUEh0UDdBcmQrUDNId2ZmbGNtc3Bp?=
 =?utf-8?B?cU81ZzRXb2puUUpWZDBrc09YTjdESkRQRWNlamlrWkdlYjJXaENxV1hYcTBs?=
 =?utf-8?B?L3pGTDhaL2hHUmhtYzRQKzZqTTFmc2Vuc203cUsrK2k0bTM5cEdtVmdCTjBY?=
 =?utf-8?B?amtmTzJnd3hQU2hNRmF2U2lIMnZmRXVrM2RuaUJTakNxL1JWQVFleGhhV0Rh?=
 =?utf-8?B?Q2dvUHh2eXd2d1ZhbFdodUNUdVkrekVacjZ0amU3OUg1Ylh6bHZnaW1kY2c3?=
 =?utf-8?B?UlR5dUZ1eUNQeHV5SFlhRENzL0xvWVI3dUM5cXVybXRtTmMzQVFXdE95RUgx?=
 =?utf-8?B?ZWREWEVhS1J6UG5PTXJmQkltdFFOMVBMVUpzVzlhUG5jN3RxMEpuSFpzTzM5?=
 =?utf-8?B?M1FxZ1YzQzJsQnY3TWYvNndScHpoZVN3NVpaa1orcmNKQkRvM2V3U2xGYisv?=
 =?utf-8?B?UzdjN3Ztd0xPaGF1amZXN29Xd1JMaEQrTVpaZ1A3YTZOTjlKM0o0VWo3NVFV?=
 =?utf-8?Q?QnSlyFdZYX+scuEXsGpm/10=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5680cc1c-066a-4215-4e63-08dde9f7e294
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:23.1295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGRCs+dh+ebHvEsud2FehpFWG2eMBIjyFiasR+lhJ4t8Z7g4EnCg2lKJGDqIsxy9MEcyX4iZuCyVHnCkkVYAXAxWfpzyy3qfD5GvM1auVEWgOaKyS7daDycpfTBgK82v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5373
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

Hi Marek

On 30-Aug-25 5:28 AM, Marek Vasut wrote:
> 
> On 8/28/25 3:51 PM, Naresh Kumar Ravulapalli wrote:
>> Fix the incorrect bit masking and bit shift used to compute EMAC
>> control which in turn is used to select EMAC clock from EMAC
>> source A or B.
>>
>> Signed-off-by: Naresh Kumar Ravulapalli 
>> <nareshkumar.ravulapalli@altera.com>
>> ---
>>   drivers/clk/altera/clk-agilex.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk- 
>> agilex.c
>> index e1ddd02f356..2ad8cfd8856 100644
>> --- a/drivers/clk/altera/clk-agilex.c
>> +++ b/drivers/clk/altera/clk-agilex.c
>> @@ -1,6 +1,7 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-License-Identifier: GPL-2.0+
>>   /*
>>    * Copyright (C) 2019 Intel Corporation <www.intel.com>
>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>    */
>>
>>   #include <log.h>
>> @@ -11,6 +12,7 @@
>>   #include <dm/lists.h>
>>   #include <dm/util.h>
>>   #include <dt-bindings/clock/agilex-clock.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/bitops.h>
>>
>>   #include <asm/arch/clock_manager.h>
>> @@ -515,14 +517,11 @@ static u32 clk_get_emac_clk_hz(struct 
>> socfpga_clk_plat *plat, u32 emac_id)
>>       /* Get EMAC clock source */
>>       ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>>       if (emac_id == AGILEX_EMAC0_CLK)
>> -             ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
>> -                    CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
>> +             ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, 
>> ctl);
>>       else if (emac_id == AGILEX_EMAC1_CLK)
>> -             ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
>> -                    CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
>> +             ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, 
>> ctl);
>>       else if (emac_id == AGILEX_EMAC2_CLK)
>> -             ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
>> -                    CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
>> +             ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK, 
>> ctl);
> Please do the actual fix separately from FIELD_GET() conversion.

Sure, will make the change.

Kind Regards
Naresh

