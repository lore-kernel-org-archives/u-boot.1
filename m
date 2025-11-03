Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F68CCFA06
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 11:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52110836D1;
	Mon,  3 Nov 2025 12:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iY69l8fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F794838AE; Mon,  3 Nov 2025 12:03:49 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE5D83642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s72lDcF2kDPxvRoCJ7tEYjwcuwco1Y/17yoMPap9h/FN4jGVPYdipjbC8uHbIxjZMKyktwUnMCC9r9gBZtcTmUrmGHVuM2oKdoK9VuJNkv5QzSIZ4DGVCnllganu45eRKkV+aQgqlUTtWz+W4vvBchCjT6epoIvRBT24ZCUII0kRk/DHoN6SH3rC7JCOHoAK8v5WWPtOeDlhqXUZnDGBmPIc8sAhXrScQb2+nQo9vKXT2k6MnETTySy2l/dIA7UuRBeFNHNQecOxF+fF5q7OmF9tO5uth3Dfr9HWmZKmEezWPX9P0QncWu5MIViawgk5sU6On6fCX0h3AwbCreMllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/gMo/92HysfeU25l14Vo0F2sx4CUlDj89TS14Bv3yE=;
 b=ouvnYCbrHEChtwFgTh4Uuj4ElY/Q+njRkjpBSmLQyieKoc3A4C1emM1djj4JAhJe2k+Zmwf0S8AjWP4Ev1Uflq8kHs/cbQqGp/wLNFUkDKl7+be0wAKiejb194Zn6xSOZ6lPzkFOKJq3EnXbXHKock0d8dj7+qGBD23AI2jTMsqLLPpgkBPtKfRJSyq4iSdGwZTuODsAl5otxABCoJAayMetSbUsaHbLYeAU38qKcWYn6wN2fMnOltoRrSuCgF+PawQEZXowrnY7+g5Kn/XZ9FEAMG2HFCqgyPyukeZidSkOU02a3vJWYQpskJDfo3s+SeTcUnDZvbCOdlt43YrdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/gMo/92HysfeU25l14Vo0F2sx4CUlDj89TS14Bv3yE=;
 b=iY69l8fBU5lYE6XBj6QX1ICKeS5z73AIsUBZ6XWcZixa73VegI/ypf4bzRJ5jlxe8AB+3UwSX9RM8QTAChzGwxy+DaaLoGXJMk4VjTvbIqWdMMIS3mYR6pgGE15TPxZ0C1rOAAm6ww8MgwoQkOtrGo7h7/VcMVFh3gbZSjRGa5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11506.eurprd04.prod.outlook.com (2603:10a6:102:4df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:03:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 11:03:41 +0000
Message-ID: <cf561be1-08e8-4a89-8a04-90a1dfead19e@cherry.de>
Date: Mon, 3 Nov 2025 12:03:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Dang Huynh <danct12@riseup.net>,
 u-boot@lists.denx.de
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <20251103085135.GB1698@nxa18884-linux.ap.freescale.net>
 <9039b700-16cf-44c9-8e32-dfdbe73f29b8@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9039b700-16cf-44c9-8e32-dfdbe73f29b8@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11506:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e106c2a-7087-447c-1fc8-08de1ac8a5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2RKN3VvLytrb1ZMdDY2RmwwN0UwNEpIVkFaS1NEWmwyMVM1c0QvMWc4Kyt5?=
 =?utf-8?B?Yjd4RURYNUFpak1TeEhQWlUxYzRJbTZsNW0rSzVsSUpHQS9wVjhxejZZSWJB?=
 =?utf-8?B?dDBHdlVXNGpZeHNvZ0RuY004Rkg0RkU4cFRPNFlOQUpkZVltSjJEcE5UdmNm?=
 =?utf-8?B?bEZxWmtQdS94dkFXS09OZkxsRWxocUc0RTRwNHhpUEIvcFB1L3FsZkNmQzBr?=
 =?utf-8?B?enZIT1UyWFhjTVV6RUc0ajlxNDlUQlNQWDRKdVhMdVhQREh0clNNQlhqRTky?=
 =?utf-8?B?TmFmeFBoanhaRDlSYXBKai9xNkNYQVp4T3FLeUl6ekxFTUo0ZnlJcXBhRUdn?=
 =?utf-8?B?T29zUGUybkxKY0J5bnFtcXUxdlA3NDVzd3N6ekg2RDdneGdCaHN2c0Y0SSsx?=
 =?utf-8?B?Um1wQkdSM2c1VE1oMkFqcVU1NDB5Q3hiaTBJUW1lUTl0SUxST3Qwb2VraWpz?=
 =?utf-8?B?aHY2bzlNMFdCQmhVMSs5TXhYNUpGRUpveVkyTmdzY3YvQ2dCOEh4NkNhNnF4?=
 =?utf-8?B?bjhoVFBFMTFvcVBNRjZzMitXTmtNei9UZzZhQWtPaEYveFlUQXNKWk9MNUxu?=
 =?utf-8?B?RjRpZkc1QlNHTzllT3NtU0wyRnpDNmpCNVlkMlRLRU1XdmZtRWV6NWJMOU9U?=
 =?utf-8?B?OE9BNlBBcXhpUUFYQ0Vqc0g4MjlYbGx3cnpMMVlkTHk0VWc0SVpKNHJnT2gv?=
 =?utf-8?B?VmNMdWZTWXJaT0lVd3Q4WlJCcTkrQ3ZGc29CSzB4dEtTNnlZNDBTc0xBbWl0?=
 =?utf-8?B?T0RoaUtwQlVZdkF3WGZHeXlINEVvNlFHdDB4R2hmSnFVYWJHZUI1bHIwS2Zn?=
 =?utf-8?B?QklIMFdFbVVwTXdsdW9WeEx0MjFjY1lkT2JHb0R5VHlBL2NIY1MwYVFOU1RD?=
 =?utf-8?B?ZmE4Ykd0OWl4ZTN2Sy8vRlE0WitmK0ZvemxGcStDTFcyeGJhTHBPdWdVNnpM?=
 =?utf-8?B?dGcxU0IzSHlRSjZjQ1pmWEhsRDd5Mk03cUJ4TG9kUHYvclc1Y2NoRm9KU0ZS?=
 =?utf-8?B?a09Vd3NaVVpJSDhabXk5cTZoOHkySDkyUTh5Wk05cU5EOFd6VXhDUWs2Y25U?=
 =?utf-8?B?VThxQzNJdlNaejkzNm1GU0FPN3UwWUtTb1VRdFM1ZGEyTDJCblNaN2JQSW9s?=
 =?utf-8?B?UEJRY0I4VkZZeXB1RHVXYnZnY2Jad3Q5OEJZeDNIQ2RkRkZHR29sSnNTK0Vn?=
 =?utf-8?B?WWsrbmhkeDNkdU5vRi94aTE4UVFOa0hLRDEwZjNNWjZCNm1FcnJCaGhWaHZu?=
 =?utf-8?B?eTBLUTliVW1FVmdrNHJWR2pWd1Y4Y05oaXdmRm5Sb1NXNUhzODJ2d2NDOVlx?=
 =?utf-8?B?bm93dUhmelVud3ZJWEhGempDWmplRFRMMzFlOXdIaGx5SitpTEV6aGIzcDBh?=
 =?utf-8?B?ai96V0xOek91VXp1dmpaeW9pbzc1UGhPZnJ6MkRJQlNuem15NDhKY2JtcDMx?=
 =?utf-8?B?Um5WcXQ3M2FlRHBUU0RCWmtjczBYVDZNUGI2WFgxR04wSUZYZGtrU1BKS05V?=
 =?utf-8?B?WWYwOWlyV1BEcHVMT3RVNzRiTURoeGRmSmNxeDg0WDA0dnNjcHE1bWxpdlN4?=
 =?utf-8?B?bFBLa3V0dXphVzR4WWZ5YVNoQ0hNc1ZlUGlLSzdMbE1BZmZQTi9mWFdaTHJJ?=
 =?utf-8?B?OGZVTUl2TXhkOTRYVEtHRTRhZXZkS1V4OHk1cWZsNzE4SS8yYTRyOERubTEr?=
 =?utf-8?B?TVpSODVKWElvUklTZUk4WGVJMmRpRU9NM3FEQUhjMzF5Tm53TFJGaktTcVN3?=
 =?utf-8?B?VUR3dGxJek9VZHpaRS93aDgyR1I3YUovNnhLNXRRZmZrNGxnamlCYlcyTHp0?=
 =?utf-8?B?TStXcUxFN2EwSEJHZGxubU8vamlraXl4VWEwZ2tCbmtFUjJKa2pybXZ5dFN0?=
 =?utf-8?B?OWhhYXpxaEQwS3R0UWo4MzlIbEJuck5YSEE2Ky9PYlk3VnN6UG5melZ6dDhM?=
 =?utf-8?Q?NkdB7zHoR3XBTaZ9k5svRcVzULhP+1Ti?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk41bWlEOUlUU1NNYS9pVUpoSlY1OHRUYmxoQlovQ29JbDZlS0xueDZyVkgx?=
 =?utf-8?B?T2ovN2xyZytKcTEvaUNrNFBSbWxrZVJmQUFWV0RYZEFreU9kcjM2S3ZZRjcr?=
 =?utf-8?B?aFFJajJDU3V4cm9FQlVpVnRzN0VlSmZPbURGT09oOENSSVNOSTVRMUNVelg1?=
 =?utf-8?B?RitNUjJUMmJsTWJqZDgwZUN5TXg4cng4TC9qaFdwUUJ4aVdjeUZpZGJwVE11?=
 =?utf-8?B?Z3pYanRuWE1aZzZxNDgwWTNUZVFBODhVUnlNZ2ZVWVpJTU5PNlJ4U2xCcU13?=
 =?utf-8?B?UmZiYW9NaEV0dWVyS1lHSjBFMGkyWkNrVFpKNWV4cm5vRmJSd240aWoyZFg2?=
 =?utf-8?B?ZGpKWGJpK1ZoRFpKc2JOMnFYTHh2THRGTi8zMHpxSFhnazNBMHVrWkJZRUJS?=
 =?utf-8?B?ZVNtODYwUU55bUR2aDFsYW1YZzJnemJwVytocHBMT0JraHlQcnNBT2kwVThu?=
 =?utf-8?B?dkxXVWlZbXp2WjZTRWN5SmRzS1dmaGFaUXRheVZmdFc2WkpDYlNMbVNiQllF?=
 =?utf-8?B?ZTNhcXdjYW5WRzEwZnY5S25XbFVSeUoxc0VpZk92OFREaE9pU3g2RTVLSWxV?=
 =?utf-8?B?cnFQRjBpVG90bUZma0NBeW44YzJ3NzkvZnJ5Z29DUUpwQWQzZ1NPSlY4ekJK?=
 =?utf-8?B?cWFRckNoT21TS2tNRTlVWDc5QTMrRXB6dnlaZnNYYVdKdVJwa3E1T0tHVmtw?=
 =?utf-8?B?WEJEckFYMWR4VmNLSktDNlNRY1YxTHZ4d3RJd1lnZXovc2lUSmlITkhLZURX?=
 =?utf-8?B?UkRtWG9EczF3MGRhUjFZc0lHUDV2RFpjcEV1UUcvOEFoaDRRSkxYTGIzaEt0?=
 =?utf-8?B?RHdZOUhUSFdza0UzZTE1T1ZCZ3RkUndQdEtadWI4UlRxZnVQYTMrTEpNUEda?=
 =?utf-8?B?M1lSVVVpN1A5Q1B1by9wTWhGQVUwR0lzcm9VbGF3SmthY0RsVFE0VzFLL1JB?=
 =?utf-8?B?WjJFUHk4SjRRaUZlaC9yZGFMSmFVb2FVYXprQWdHVy9kYVlWMmtVYytBL1Ey?=
 =?utf-8?B?RW1hQXFiWkgvMUlJcVNGdjFxdWpmZHlEV2xDNmhLRlo3RzFsTE90TnFsc1da?=
 =?utf-8?B?TG1IWVVWenE3SEVuN2hJYWdSNjJxVkhqVTkwejhzZW1ZcHRJNlh5L3lLN1pE?=
 =?utf-8?B?V0c0cml6VEd1UTZCa0xWNFhzU3daU01sdy9ZcEd2WEF3Nm96UXhjdEVGeVcv?=
 =?utf-8?B?TE5McWwzRUVZSVl4bW9sLzlSK3lwYVF5dFFOUW9Ebi9pdHlBOFJIcFVUd0JJ?=
 =?utf-8?B?dXFpVEdFczFZUTFXSmhyWWx4RWFHc1hmN293M3J2bTR0dkFUeVArWWUwZGJk?=
 =?utf-8?B?RFQ4MVRGSjIwazVtVms2ZFhYU1V0bnZROGdiNzhyU3N2VmpMZHpabUFoR3dZ?=
 =?utf-8?B?Y2pHRm90bVlUeDkxbzJPb2hDN1p3bVZQY0daeGFLRm81dmtKS3dYbDdMUEIw?=
 =?utf-8?B?L0s4bVVWNlRLQVNoOGtwcWlCeTZOYjNwZ3BXWlk0aHdBUnUrUXJhN2JGbTBY?=
 =?utf-8?B?aldNc2N0Qm0raWQzRHhIYTNnVWRiV2hyUGptaHFvN1V0ZDdnMEREVDRXK0xG?=
 =?utf-8?B?SE5lNk9EY0ZyL3pwTXJnWXRESGFKR2MyRjQyclltaTV0ZDZaWis3blpBS0g1?=
 =?utf-8?B?QnlOajliVSt4QUtwYytnbGZsa3l2VDlLTTViYWJLS1NrU1JhNXBwNGZNMXY2?=
 =?utf-8?B?dkZlNjMzVDltMGRiVGZONlV2RUk4aEJQNEFiaGxLNWtOcG9VajFnY1lGWUVG?=
 =?utf-8?B?TEpOVGxhUExCTDRRMTBPZlJ0OHNYTVFGbTFkTGFXcUNGU1lsaUpobmJKM0dP?=
 =?utf-8?B?dVRjR0l3bXE3b0h1QUEvNVFOSUZjRFhaVEZPbDlkNTZ6ZmJXNFdSV2FZQWNL?=
 =?utf-8?B?RzFnY3E3SGJ2SGZ4QzM4VnB6ZGpXbGNkKzRoQUpsbjFOMGZiT1d1bGJuaTFB?=
 =?utf-8?B?cm0zZWhqVm1HaW5FSUNxQmtISmVCaW9xSWo1QmJqOGc5bEk4Ti9Gcm1oQUVZ?=
 =?utf-8?B?UjNGMmo0WEd4ZUpSR21NT1g1eVNMa0F6YmRYMHY3bG96ckxWUGNlTGVteWFU?=
 =?utf-8?B?UkdiSWZoRVRleld0NUkvV3czemhXbDRCKzc0TndiRjErMzhzU3Q1TENlbk5N?=
 =?utf-8?B?Nk93dEZnUlkyZkd4cVFWZmxhYmJGYVloR2M0aFJYNkxKSCswMXkwdEVEcVVv?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e106c2a-7087-447c-1fc8-08de1ac8a5f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:03:41.4851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu8D/0cReG5bBHsc5xuAD3x6D3dOusnxToxn8rL4bj0iLWD1epBglb0cSI35H0ujweXzYxTl41S1XsoZ6PWmUJXF7srXR1iFEfHltTAZ4mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11506
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

On 11/3/25 11:36 AM, Jonas Karlman wrote:
> Hi Peng,
> 
> On 11/3/2025 9:51 AM, Peng Fan wrote:
>> On Sat, Nov 01, 2025 at 08:34:26PM +0000, Jonas Karlman wrote:
>>> Rockchip boards may depend on a working MMC regulator in SPL to
>>> successfully load FIT payload from MMC. Typically, these boards only
>>> include the vmmc-supply regulator and not its vin-supply in SPL control
>>> FDT.
>>>
>>> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
>>> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
>>> boards due to now requiring the vin-supply to be included in the SPL
>>> control FDT.
>>>
>>> The commit also strangely enables any found vin-supply in
>>> regulator_common_of_to_plat() and not when a regulator is enabled or as
>>> part of regulator_autoset().
>>>
>>> Revert the commit to fix FIT loading in SPL on broken boards.
>>>
>>> If a board needs to have its vin-supply enabled, two options come to
>>> mind:
>>>
>>> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>>>   any board.
>>>
>>> - Implement full support for reference counting of regulators and then
>>>   update the regulator-uclass to enable any found vin-supply when a
>>>   regulator is enabled.
>>>
>>> This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.
>>>
>>> Reported-by: Dang Huynh <danct12@riseup.net>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> drivers/power/regulator/regulator_common.c | 10 ----------
>>> drivers/power/regulator/regulator_common.h |  1 -
>>> 2 files changed, 11 deletions(-)
>>>
>>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>>> index 3ed713ce5019..685d8735fa5c 100644
>>> --- a/drivers/power/regulator/regulator_common.c
>>> +++ b/drivers/power/regulator/regulator_common.c
>>> @@ -44,16 +44,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
>>> 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>>> 	}
>>>
>>> -	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
>>> -	if (ret) {
>>> -		debug("Regulator vin regulator not defined: %d\n", ret);
>>> -		if (ret != -ENOENT)
>>
>> I understand it might be not proper to enable vin-supply in
>> function regulator_common_of_to_plat().
>> But I have a question, there is -ENOENT check in the original patch. If the
>> board does not have vin-supply, there should be no issue. Or I miss something?
> 
> As mentioned in the commit message the SPL control FDT does not contain
> the regulator references as a vin-supply, this result in -ENODEV to be
> returned. I.e. following where the vcc_io is not included in SPL control
> FDT.
> 
>    vcc_io: regulator@ {
>    }
>    vcc_sd: regulator@ {
>    	bootph-pre-ram;
>    	vin-supply = <&vcc_io>;
>    }
>    sdmmc: mmc@ {
>    	bootph-pre-ram;
>    	vmmc-supply = <&vcc_sd>;
>    }
> 

This needs to be fixed for SPL FDT for all impacted boards then 
(Whenever the patch adding the enabling of vin-supply is resent). We 
need the same bootph props for the node pointed at by vin-supply.

> With the change introduced in this commit the core gpio/fixed regulator
> behavior changed and this now result in unbootable boards.
> 
> Other reasons why I prefer a full revert instead of a workaround:
> - The implementation changed core gpio/fixed regulator function without
>    any review-by or acked-by.
> - The patch was quickly merged after only being on the list for 1 week,
>    the imx pull-request that included this did not even mention regulator
>    changes.
> - The implementation is not optimal, looking up vin-supply could be okay
>    but not failing because it is missing, and enabling it during probe

If the property is missing, then we shouldn't fail of course, since the 
property isn't required. If the property is there but it points to an 
empty node, it should fail? Since the vin-supply could be one that needs 
to do something (e.g. a gpio-regulator whose default state is off). If 
it's there but cannot be probed (e.g. gpio-regulator but the gpio 
controller of the enable GPIO isn't available in the stage), we should 
fail as well.

>    when we already have working enable count and regulator autoset to
>    handle any needed auto-enable.
> - The commit message does not give any insights on why this is needed.
> 
> My suggestion is that this is reverted and if needed it should can be
> submitted as a separated patch/series with a proper implementation.
> 

Agreed.

1) vin-supply isn't a regulator property. It is a fixed-regulator and 
gpio-regulator property so it should be handled in those drivers and not 
in the function common to all regulator drivers,
2) Parsing the property and mapping in *_of_to_plat is fine, but 
enabling should be done when enabling the regulator, not when parsing 
the FDT,

Cheers,
Quentin
