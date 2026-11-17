Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC512606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bQOUtNn5;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=C/3j5/lb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8388680D62;
	Tue, 17 Nov 2026 07:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8coIX6qlbRC; Tue, 17 Nov 2026 07:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2DCE80D92
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794901895;
	b=My21R+LngZlGlQol/emwG7nSWQu45lQpmIL2BLrSfDI5qcLgwe/xRcy42wBqTNv9RTKB
	 rAmYOOjsfQaIIjtFFWldA/QlLmZ4jldzHGuAEw15XR4LI6kXBPorCSLQLfN2iVaThgf2N
	 ekw9oNp9IlPMhx0MFzeUqdOoiLkAPK+AgcjvbMjCZN4uGDDAuiSexAtbInJC5G1DFaj/m
	 VwONDjhI5eoATykUQJO2V6FxNV0k8WHJqLqKUQhy51E6UdAgrDH+bimouIQ4honlbeOue
	 Knx5udGmv7HLe61Mzus59xUFOuEjdJKmCsTfA4XOU23XscjT4q5h2VBuiRokk8FOZFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794901895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r2UXSNLHXLzpbEjeO06C76fEQiqIUWPMI30O+lKL894=;
	b=LNCAKNq9Kp4BHZgFVtD0RxLuncIUerTlZdhmZomMfFtO7UgabPKhlr3W/peXllZ5WSR/
	 p9GNYaGA0M5h84Zz8zHC3ajv5LZg2wBSPSYCbIysz83FlNnpDgTtcIsf8rMDY93MryrB3
	 mm4JYehKDSaYjHDOt4GksS6cqsHTRFIoZuFncGX4ZrVMuNQ9R5Nq1dCdIUfCIKwdnzfBa
	 M/FnG7whEqDkK6kPMDO6UJa/l/JHuOOW3r30iU87gDOOmy3kkhEgWyUzJxMO4vgbVCfZ5
	 tkJTcaGZ5nuKk7d8xDpThSrVYGoBaMepFr1eHStmSk6V+hucZHgyq4iAZxd8JdOxyzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=iopsys.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b="C/3j5/lb";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794901894;
	bh=r2UXSNLHXLzpbEjeO06C76fEQiqIUWPMI30O+lKL894=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQOUtNn5qB2DP1yFaUKVu/417lnWd2EnWEuxfvMLOalIRdUubHpa+LuDxumex2qmz
	 z13xbKEgGUuh9domCocd1p78QCeww98O694lTlFWFViAkVY9I7yacBL0+cZ+jj/Icg
	 /kX7UUVnSStZXUGX/YM9Zuhvw9XFaJQenarZQTJZeQPOF7JMiZuc95RanI4ITMnH7b
	 1ik5+Fmd4I6WLQiGPxMlGygy1YN/iDNu5w4mP3t6NpKr+d7+slY4MMiVcYhuSJQFOs
	 ZpmSERGEb7Khq06Wo5dSEx4Pv5+8IDtrxc+ZKYJRqLwDrCAL8M9rV6mc8Ho3YANqQ9
	 J8AT8n430vMng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2DCE80D92;
	Tue, 17 Nov 2026 07:51:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBA9928C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C61FE80FB4
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfBPlo4UNd-H for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 07:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C407080D62
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=C/3j5/lb
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C407080D62
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2UXSNLHXLzpbEjeO06C76fEQiqIUWPMI30O+lKL894=;
 b=C/3j5/lbqMapfCQ7DA/wD8bqPtkQQgsYE11XFXt2NXeNOQHcgjsprBKLgeIhghhDKIsnW5Z+xXfAhdWu3uoFLEMsLtwva6A3mhJNmZxZI1RhDQjJKy3u9od4JZhpRnVuLE22wW/m9TMpgA0nO6gThlZWwd91Z5DBMztu7Eaa+u/ZrdFjoGfMWERCRQjY9nDlg1SB4kvUQ1v+KkfQAeV90H0lzEKTJ0r4l671RDJiYay9ktevVVzo/A6PfVZutYJXSNKHHRwsm9GdZxG0dLhzbC66rGqPhLHCzSt8msLvMUP0GJpf/am0fVFxYCfRCYqQrb8diDF3sMTNkw60FrOu2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:51:27 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:51:27 +0000
Message-ID: <77f9017c-1b17-4da4-a39c-3074caaa9b42@iopsys.eu>
Date: Tue, 17 Nov 2026 10:51:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mtd: nand: spi: sync spinand code with linux-7.3
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-6-mikhail.kshevetskiy@iopsys.eu>
 <ff78088e-83ed-4bae-b17c-938c8587dd24@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <ff78088e-83ed-4bae-b17c-938c8587dd24@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: c1882451-a55d-4b91-311a-08df447f9596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|4143699003|5023799004|56012099006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ObR73B9knkGoAtCWAk5FFNgYFY0DM44E6tZkkuJ4tZ16UhnkHvvQJL5qescU/DSmhcG5/0B1R7cVrGcvqp9EXZaBZGcEyWwtxkDXw0f3Zq483U2c399uK8tJF5WwO77KGWsOMKDGT046uc+ttrgmMUdoarhI9oMDWq0ZKaTCGGyvZncttMpU/CeEBAJCZmpJpOXXAGm0dwIPAclyTxITbPBxgKdYG/qpwIrI8vVytUVumZEIEEawi1dGY3OmyvOGs9Ht5zHBIj1zm0Ufuv2mj+kU/9/9MPGf3kxhfYJDnqg1rKdn4REVTNaTMtUFh7Bpi1szDMhdq+LfZSDmvVqgA293QZQsFbfjQAN0/9KLKttU+jUCHXy4d9VN/8XU/Dr0Jf093nXVU4CRvCRpZyo0r5BUORtOOwPXsKnro/qC94cUl6B3x/OUFo/OfOHVyFCSVXFb44SIWmzGNwXULdedr6VTw5RbJOExe2Wslj50ApeHTg1vO3Wf8dtXwjiIHEciu5iaAUTF6RoweHw06gDSEBnj50sGiFLUR5TMrcP9bOi3ChihYi/601T5nO+ucHBLzvN7TgW8k2Qy6GLwOLroza7OVVeuC7vQNxSB1KtiG27zUF2kW8Sy4fLfjU0t35+O8BGbz7T6zVZv9tW0+G2pAkxGZpWR3Bo1J7/YQGnQkCYRwC5bCDNY3MZZeiZDXeGFGhLIFcPc5sF58/sF/J8Osw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlrTFVMdWtaek51eFFudG5UVUtwSzZaa3BzMEFhOW5iSTdqVTdkTzJFWXNG?=
 =?utf-8?B?b3YrdEdMS0ZXVnVkVDFwR1JJcEFmYU9mem1IcXVqNXVFaFgyNGluR3RUQUxT?=
 =?utf-8?B?YkR5dWg1MmZXWVpXcUNKNkw5U0UxUFcrWnN5Y1JEbmR2YTNUL3lxNVpGdXYw?=
 =?utf-8?B?RUR6REZzNTFqbnhJYVpwS3hIVzdJRU0xZFVZMFp5L0RjTXpld0d1WW1iV3RF?=
 =?utf-8?B?QTg2RzNQbVBxZVFia2VYeGVlZWM5ZFdNZG9sa2ZtZFlpbjYxNWNwQVAzR1l4?=
 =?utf-8?B?Sy9NbSt6ODhwSFBiNG9tN2YwcFo2MWNGeW5McVp6VGxZQjAxSVdiZGVlTTVR?=
 =?utf-8?B?b3dzQkFjT1c5cmR6Q2d4SlcwbjRuS0NUTkF0YW5wY0tDN1VGQVl6UG5DT2pC?=
 =?utf-8?B?Qm9Bb1M2OGVleWJ4ek9xSVJycjF4YkJOVGVYMVlKSTFXc2d3NTh0Z2VXdUI0?=
 =?utf-8?B?WFZPcE5rM3RmeXpjWUxwU3ZBbzZzNHA1eW5lR05SOExsd0tDU1Fhd2ZpcUUr?=
 =?utf-8?B?b0gvVzRkdjFrSkFZSHdNV2ZRQ1VNVllyTEd6VVN5U1pPbWI2UCtDcFN0S0hq?=
 =?utf-8?B?d1lFR21SMDNmQ1ZPTWlkZXJGNmI0MkU5QnVHYjZaM25rSGFGTVd4RzA4cWkv?=
 =?utf-8?B?YzNzeEZ1REQ3TmVqNWJ0ZUs3ck1JenNFZXRCVE9Gd2RyeGoxQkNXR1lBYVZj?=
 =?utf-8?B?eENHaTAvT0VralpjS2I4SFRoZUhFRno4d1JhOHo5VWUxUjBxOGhVZnNESytZ?=
 =?utf-8?B?SVRaTnJPeFhIcFNxT3V0d1k5Nm1sU1dsZnU1UVRSYnhnd1ZkbkE1SVhBWGJi?=
 =?utf-8?B?TktDcGVPTmo4ZkZqNWpwU3JEYWwvdG5CcHN3V3laeUpqS3VkL0R4bFVEYWZl?=
 =?utf-8?B?NDFoNWZMOFZ0MUNMMlQ1eWh2R0pPN1haUlRVZlpkQ3ZBOFdGQ2FsOXJQL0JM?=
 =?utf-8?B?Vzc1ODlCUmlTdmFDTXV4Mi9PTEJEekV0d2FjemJhSVlaRGdZMXZzR2tGNlYw?=
 =?utf-8?B?UkRLM0htZlhLN1lJR3lhR3hCdkhqa2tyeUNDZ0JmZ0ZYSWMrOVg5TUtUblhG?=
 =?utf-8?B?cG9HY0QzMWFUVmp0K2xydjJHZThYVE5KTjM4SzFlNjJKMjN3YjMyZ1R3N04x?=
 =?utf-8?B?U2FwSkxkSEZXT0dhL2hibFMvM0thYXNyaFc4ajMzSitsekxRcm5PbVBRS0Jw?=
 =?utf-8?B?dDdmczh1TWFlZFZpbzhTcHR6Zkg1N1dLVWlqaWppTEl3QlpqNGRvVmpMeUV0?=
 =?utf-8?B?aTdmR2xYbHROQlRCNjhaN1F3ZzBhaWVtYkUycDNpdHNURVFwa2IyOTZBVUt0?=
 =?utf-8?B?c0Z0Y2JWVm5Qa1VIcHZyZ1VxS0ZReVJWcFFWKzhvdlVnOGN1K25aUHNVUHVE?=
 =?utf-8?B?ZEJoaEZqU1hMSmxJY0hlZjlSWmFadE1oWEcwQWxMdmN1YUlhK1E5c2s3OVZl?=
 =?utf-8?B?TFUxR052VHdCbWlLTm9rOGlVRWtKS0hWRDhuL0s0OWUyZHh0djlrektDK1o3?=
 =?utf-8?B?MDN5OGJrUEl4aTlrMTlzR3h1aVc1Y1BWYVI0cjJDNU9iYjZ4amNwemVwOFl5?=
 =?utf-8?B?MzRwelBRcmJJeFVlczh2Sm96bmNLNm9YNmhGVnYwQnJCdFFUUkk2NHh5Q21V?=
 =?utf-8?B?Ym83bEUzTHdxOVBVd05CN0Rpd2hOZm42SVphcmtZRzRONGhMYVF4a3hkUDh3?=
 =?utf-8?B?a3cxb2lHRmVQWStHTnpScWZWT3B1elRCd1N2MkN4VW5PRUZKMVI2cFBHRjdD?=
 =?utf-8?B?ck5aSmtiZ3NyeFlqTk9xV20zRUJlUWs0MjlEY3NFRlZ0Zi9DTkNGaytyTzMx?=
 =?utf-8?B?Snd5amZ5cjhZZHM2Vlk0b0k5Mms0YlpzTE9hMTVSeEZZSEV5aWRoT3Z5Q1FO?=
 =?utf-8?B?T29UTFJPWld4MGxGYkdMV0dlQmJ6b1hkTXQ4bGhQNWp6dllHbjVGdEhUQ3A0?=
 =?utf-8?B?MkFMRHF6M0VuMm03QjJON1FJRXpENDBxQ0xZbXdROWZ5czllY3haS2VHMVdm?=
 =?utf-8?B?cHB5U0hRTTY4b2JBRlp1V2oxbkQyTWhJY0psM09teVo4cEc2M05GbjE0cmYv?=
 =?utf-8?B?Z21oVnMxWWVoNi9LdllXeEtCTmF2SWZlVHRZaGtFN0g3WWNSbHFuNVp6VHNz?=
 =?utf-8?B?ZDdQcWxnbTVvK0p0MVRBUVZUNndXNXdIeEJxMzRTUkovQXdFTTJ1T2FhQytY?=
 =?utf-8?B?TjhTY1RibzhhRDBIM0pRYzJsZUIxQVBvaitKVmdRZHFHWmt3NXhQMHdoWnBJ?=
 =?utf-8?B?MWVoSUFaUFFERkF2bmg1dWx3c2lVZlMrTzhOOGI3SlIrNTc3Q3BKUGJvVGtt?=
 =?utf-8?B?bXZ1WjFFc29IYWNMbXZKdkdNRkJwNTFKb3JUd3M2Z2lxOG1oQUVsR09TWDFD?=
 =?utf-8?Q?Y+6lvLcoSqcF60n0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c1882451-a55d-4b91-311a-08df447f9596
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:51:27.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6+cNgt9fWhlh/GcNW2gwRwm2oF6pcEAqr6IRaGtlzqCM7JDqjaUAz9K0yN/O8wosrTVVFLKg8BcMm5OFycozfpxvuqxmFgqriM8NbbTpp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/7/26 10:58, Frieder Schrempf wrote:
> On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
>> Main changes:
>>  * add support for spinand operations working in octal DTR mode
>>  * randomizer support
>>  * continuous mode improvements
>>  * more flashes supported
> The subject line mentions Linux 7.3 as the source of these changes.
> Maybe you can make this a bit clearer by referencing v7.3-rc6.

In the time of publication it matched Linux v7.3-rc6 with additional changes planned for 7.3 release. Now it matches Linux v7.3 release.

>
> Also this patch is really big and contains multiple squashed upstream
> commits. Is there any way you could split this up, maybe even using the
> original commits from Linux? The minimum would be to split the core
> changes from the vendor driver updates.

There are about 50 or more linux commits squashed. I think It's not
reasonable add all commits separately. I'll split on 2 commits: core +
drivers changes in v2.


>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/mtd/nand/spi/Makefile     |   5 +-
>>  drivers/mtd/nand/spi/core.c       | 504 +++++++++++++++++++++++++-----
>>  drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
>>  drivers/mtd/nand/spi/esmt.c       |  30 +-
>>  drivers/mtd/nand/spi/fmsh.c       | 175 +++++++++++
>>  drivers/mtd/nand/spi/foresee.c    |  34 ++
>>  drivers/mtd/nand/spi/gigadevice.c | 117 ++++++-
>>  drivers/mtd/nand/spi/heyangtek.c  | 132 ++++++++
>>  drivers/mtd/nand/spi/macronix.c   |  87 +++++-
>>  drivers/mtd/nand/spi/micron.c     |   8 +-
>>  drivers/mtd/nand/spi/toshiba.c    |   3 +-
>>  drivers/mtd/nand/spi/winbond.c    | 466 +++++++++++++++++++++------
>>  include/linux/mtd/spinand.h       | 198 ++++++++++--
>>  13 files changed, 1639 insertions(+), 213 deletions(-)
>>  create mode 100644 drivers/mtd/nand/spi/dosilicon.c
>>  create mode 100644 drivers/mtd/nand/spi/heyangtek.c
>>
> [...]
>
>>  
>> +static int spinand_randomizer_init(struct spinand_device *spinand)
>> +{
>> +	struct udevice *dev = spinand->slave->dev;
>> +	bool enabled;
>> +
>> +	if (!spinand->set_randomizer)
>> +		return 0;
>> +
>> +	enabled = dev_read_bool(dev, "nand-randomizer");
> In Linux, we read this as u32 and leave the state unchanged if the
> property is absent instead of disabling it. We should use dev_read_u32()
> here and skip calling set_randomizer() if the property is absent.
>
>> +
>> +	return spinand->set_randomizer(spinand, enabled);
>> +}
>> +
>>  static const struct nand_ops spinand_ops = {
>>  	.erase = spinand_erase,
>>  	.markbad = spinand_markbad,
>> @@ -1226,10 +1366,13 @@ static const struct nand_ops spinand_ops = {
>>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>  	&alliancememory_spinand_manufacturer,
>>  	&ato_spinand_manufacturer,
>> +	&dosilicon_spinand_manufacturer,
>> +	&esmt_8c_spinand_manufacturer,
>>  	&esmt_c8_spinand_manufacturer,
>>  	&fmsh_spinand_manufacturer,
>>  	&foresee_spinand_manufacturer,
>>  	&gigadevice_spinand_manufacturer,
>> +	&heyangtek_spinand_manufacturer,
>>  	&macronix_spinand_manufacturer,
>>  	&micron_spinand_manufacturer,
>>  	&paragon_spinand_manufacturer,
> [...]
