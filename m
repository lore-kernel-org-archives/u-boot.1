Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58D5CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17313847C8;
	Thu, 25 Jun 2026 14:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aEdnnlsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323C884894; Thu, 25 Jun 2026 14:54:14 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27CCC8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKaa7S7f7Fda6Y6wY/XDNt6YU44oZeIUixO4/eNy7wLzYIaq4ktQiC3Orr3sBgf/LqzhBKWU+7VvlD9TrSpIByahIGXjof1no3PVVP5VnK6/9HqHjymISjV3jDmCbj4PDBLFBgjaCzpW5tW7YSwopaNmhLcBu3nzgC7CdXaZ7Th91LDPMc5UM6pVN9/RxY9DgguVQyglovjC/5cH7MsJIRPA4EhoPwaGYQeehzlOGTEJfAwI7YK1npEZvrTrDEmMapfgQueGFfrVTIZeaUFwKx1C93+Jc7G+WVwkaqlQMa807BlAT4uELskRcqv3CQr4Ir6LA0wOMuLWLtBly+MRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeklfXRbFmQJy8TPqjoTti1LXNQYCp+ZGyW6TcMly8g=;
 b=Sg/xjWsKPjSyKq6+gpg9f9tIItaXuyy/xwAqMtF1mxI/eLmt77hlRQbfgZyzRiPkyx5U2cTyzO59qjsPznlvDlaV9JBu+WGVBHAZDue+fwPod4UHvSX5Se1b7jfmAU4Y3Wt14llDVfKPHIfXbDRVS4ygV94VfRfdk/7aVk5+j3wV2YpQxb4cHb0YnVn8Jv5CZvrFV81g7mSPHerDDvDHsMjv7trdJ/eP7vSMA7riEj7Zancq4dQ+PEubbyoVQGSJLYPwSUwZilfFNqJdxXwCCnDuns8WsZHhEgW89fWeUcoJkFCbsPJUHseHj71scGlhmom5bVD2I+RwT0rmu1g8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeklfXRbFmQJy8TPqjoTti1LXNQYCp+ZGyW6TcMly8g=;
 b=aEdnnlsw0wlXNmOU0SkNuFv/YM2BpBQUqpxOLHLAprfHM4sYi4OBWYdUBmkhj5bBGNrAZ5kO/cyqhTRw86c5K2QGbfKN1+veupi/eUu5EuOFRF0r0D3Wy8qyA+/7waKEzc8iI18ZLzhdalRBWxpWEyIZW4tqnj/j1NL3jt14TAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:54:03 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 12:54:03 +0000
Message-ID: <2f36b972-a8e3-4bf1-8848-5a9fd8c9713b@cherry.de>
Date: Thu, 25 Jun 2026 14:54:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .mailmap: map old addresses to their up-to-date
 counterparts
To: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com
References: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d595d8-5e22-41bf-37c9-08ded2b8d559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8wtXi2a5yOdK6wmQLm0DG/bSw8dXyV1tVeWzQJqtNVdwKXkcodPE4q9uMLjNGjlkN1rZgk4Xo6q12knILhvPf0w2tdNy2E3eU30sviNOgNUs5jUeuyD5pmVJ1AkhHf9MUaDqZ96yAFhDw82uMqn0vGJhObQevweDH4dhGaiNfeo5iUkhmRbV9NHZIPzpW+0zaOTZOC7kKT+PVjty5vbchIt88FgN7Kfk9JH2fqV1VMEaJbp3JBEFhGLgVEGRkwoeGM5yTpST7IJutCTQG5AdaidvvZchm8CI5HprjDRxE0NSjTOgyE5UWilBnWZ0U372x8kJ81Y1DRIEN8M3+bRkuaGQvL4C+wmGA4cQFGLHUv47EdJGh3rP3JEy56SvBKa9Xg2Oi4llegkc/jkz3Mh8sRnXF4z0ThcLj4mWwoyB1mDbvTCwoVKnFaUHRccM4pVbYcVr+Lwuakg2l7aXPQDXhGRN0aDgd2Q6zk4VGEw/+3KxSjgQ2Q58OzlNX8zLEqa/2HfDqY9LYJnbZ8Dl7g2lmVLGoSMmt5pUia79bXhde9W2xjFLJhO1XH2X0IdfKhy44oYUJ0NnH3BV2tNUR6p4TPb9j9UJ2V5Ob6TuUMBPRXRk3pDRjYhO2v6Q/Fbxr3qoxrmjlGzJ2If6keCVGAbBOe9FeScwWrBoGO5XS7Kzfsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG4zK1JBa1lpR05RanBLMy9vMWFYemh4S0dPOWFQZjgyU0JzSTVTNy80dFJO?=
 =?utf-8?B?a1k3Ti95YVlGSm5wNzk1Wi9IZ3lQY01CTE1xR1R0Z2YzRmJVWVBtUDFJZGEy?=
 =?utf-8?B?NFRYN1VRQmI1UDZabUZIdS9ZZ2hXQjUwWTZiU3hLTHNuT0RUVGt0b1QwNTRr?=
 =?utf-8?B?Sk16ODlpL3MvSG8zWGJiZ3Z2eGNnanhkQ3FJZWVUaEVKQzMzd1Z0OWt1a1px?=
 =?utf-8?B?NTdiYWRXdFF4WmpLcnUrWWRwV3BWUWQxTHlRQ0RTN1hFU0RCekU2QTY1KzNI?=
 =?utf-8?B?K1VUOU4rSVllOXRaajhWdkk5M2ZzQlNRYkhnN01va0dQUjJLZGlibllCZS9z?=
 =?utf-8?B?RlpHbE8yNUwzQzRRTSthd2tyb0g0SkhVYzR6L2dlWXdwVHBpcEQzVktQTEc1?=
 =?utf-8?B?SUxPajVBUFlSbFB2Zi9JdDJpMVpWb2JhMHpvS1dQOUx4dTZFejZnZmx2ZVl5?=
 =?utf-8?B?N0FuY2NvL1J5c2g0TzJYbFI5K1Q2VFp0UWl6ZkRtM0VHUzBzWTdYRk9lL1hi?=
 =?utf-8?B?bHY4KzJxZngxNWQwT1dvWklvcXo3SHo1bUJoWUNtSEh2d3E4RVJkN01YbVpl?=
 =?utf-8?B?bm9keXNvOUd1b1g5UFZRYkZ2SDdaWVpnVGR3aXNoVlhtbVlMR1pZV01Eb0dn?=
 =?utf-8?B?cDdmMk5oQVF6NHhQYTc5MGxzRzZWTXRWV3ZPdUZXa2I4WWR2M2huMHVvNUYy?=
 =?utf-8?B?VVdhOEJXSzlnV3FoWjN6UWRrSEpiZXlWcE1qa0dlS2NLRmx5ZlVpR21TdWFh?=
 =?utf-8?B?Vi80cXgxeFZHdllERU84VCtDa2RsOWZZNE95M0VrR0VpNHVvcVNkUmpueUVy?=
 =?utf-8?B?ays5UkhsN1JjeTZmWmozRHkxWCtlenhQdWRZcjZsdDNpbzVUcmdEQjZQcVRw?=
 =?utf-8?B?V1VQRWV5bnE0UEE2eWNzSjlOQ0UwSGRnWFdubVlDbEQwVkhnKzR4OGR4TWxJ?=
 =?utf-8?B?RmVZRkdQTU4yVkx4UGdXcFVSTVlrNEFOU1k5MXJwa3JjZTVIZE9LcmVzRE1E?=
 =?utf-8?B?TXJNaC9ISVRpckVJUkN3QktnL1FnRWQ0UFdtc2tmRytVOWxiQVVteW13YVA0?=
 =?utf-8?B?UEFSQjlKNTJ0OHExUTNzTVE2VS8ydWF6d0lPazdhYzRNNEdGTVNTcjBUQzk5?=
 =?utf-8?B?NmM0aDJHcUYzdUVVT0tjSFo0emdqaHJmQ1BLNTgyTjZXVUhkcUkycWlwYTVD?=
 =?utf-8?B?WjFGRXpmTVlDVHJOeHNWQnE3cng1SGtjSUpJT3BjV09JNW91aXZldEhmbnV0?=
 =?utf-8?B?UGZMZGFvNkJIM2prOEhQazRLei95RVBKWHhkV2tobFprNzNHb2o3Y09aRWRk?=
 =?utf-8?B?dDROV3A0UnZwYkhJSS9Wbmw5S2xZRi9EcGE1VDZSaldEdTZHUm85RnBXc29t?=
 =?utf-8?B?c2lkUmVTTWlRUTJVbmxVS2JSRUlPTkdKNDgrOE5rL3NSZU1nc1JSaENWVnRv?=
 =?utf-8?B?cGYvVURjZHFBYi9rRWJOR281eUtmRytvb1NkZHUxVUtqSVovR1NwNHNGTllW?=
 =?utf-8?B?b1l1UTgwaUZXMHc2YTQzZmtYbG44NGY4RlF4NEFoUnNtb2ErSHRtUm9KaGEy?=
 =?utf-8?B?NHl3dUl0dGhQQUhQSmdoVytZNVRWZVBnN1JJMUlqS21zQXJydjZ1NjJaVDA1?=
 =?utf-8?B?ZGZtSEQrVmxxWHVVTkZjUEdBbEs4TVorUS9UN3JZR0sxVFIydTFNSUdPY0RH?=
 =?utf-8?B?dFZCSWVjeXV0bVhYVDhVeFB2K0pGVmNaaHJmd245S1M5NFJTeHFvM01Qd29t?=
 =?utf-8?B?eHVEVHR0SlMrL000NFJjRmhYRmJiRk4xYTRyVkovcHNJaHJKOTd6ZHl4bjF1?=
 =?utf-8?B?QldCbjIxaTloOFJhVjFlRnN4MW10RFV1WUdrNjQvam1iWnBpUWMyUkFDZ3Jz?=
 =?utf-8?B?bEpKSUpKdjdISEYrWVoxdVhpRnZFUE1vbTZNSkFPakFRcDEvRkJpdHV4MURn?=
 =?utf-8?B?L3RTVkFQRHI0eDRKUWhUak5xTGQzWGVxc0NnQkkzV1hId2lwL0tvaVpnc0Er?=
 =?utf-8?B?eU1KVE56ekZoNDdyU3NrTmxyV0tCSC9YWTM0aWRPNWlBdnROaitCUnBNSERx?=
 =?utf-8?B?dlg1RnZGbEtlNldOcklwSk5wSkQwUkk5c0taZll1bFJLVG12OTArdGwrcnRx?=
 =?utf-8?B?bjZZWXdsZ1U4NHBJMGJYOWN3YUNNc2R5aUZsUVlGYVVTb0I2bVVTdjlrT25O?=
 =?utf-8?B?RWo3VHYrdldKSVNsL3pzd0tSY1B4dVhEdDlQREVyR0tXL3NFeTh2aUNXT3VL?=
 =?utf-8?B?MlB4dHBPK2lEeUdEczY5TUk4OGJTNmxhQzRvNUVZa3FLQ0Z1NFNWaHlrYXdp?=
 =?utf-8?B?SFVmOFFrb09tK2R6VERiZUZ0aDdRK2RJK0NJOE1qWnd5amh6MFp4UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d595d8-5e22-41bf-37c9-08ded2b8d559
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:54:03.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OZrwx5wrLIp9EzHedbWfkZ2PYrZefa/zYtWPBHtPOJMQSJI+MnKCbH+xq1nV3girw/COozBZGAonQBJC5N0o9cQm/1SIRx7YPqudlgd1yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
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

Hi João,

On 6/25/26 2:03 PM, João Marcos Costa wrote:
> This essentially maps @free-electrons.com to @bootlin.com addresses.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for the quick fix :)

Quentin
