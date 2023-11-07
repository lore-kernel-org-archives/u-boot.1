Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE4BC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D81E9870C7;
	Tue,  7 Nov 2023 08:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BhvXGoSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD5A870C7; Tue,  7 Nov 2023 08:33:41 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0703.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169A586590
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9dI5OhISfDRVMGSirkiFA2CG6EHECwFOvRdBJ5Nzrql3HdM2F+NbEMqrhgftorXS3IbRCqK9VzBww43aW8ZpWIwH5yrUaHrW2jVkSBjToi0wTFIpNd+c9iqwHo6ZOup9qjY4P2HHU0n3lBVtNuuXJJ6+/JRvldSuA6ZEJn1UelDxqOCJNg7qzPbXzT7oIAaiUTZWi4iq8rnGoN/oG3cSP4QTqx3rGCaoNLTgsQtWeMlgQEANkTC/ZHsk3HCBALBX93zNnhrJ1nC/WlytVYdO6adobU0Ev29AUYujTqYQZOfJ1O2Oqi49XfQpO2eu2c2t1GN7WvT8h5L0gjHAINTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMs+REJH0rio7KbtS2ndidhTv4HZU/d+u/HK8E3PEJQ=;
 b=n8qdNm1E/3KaEE4OYxFkW3SfeZBJACjRdaNWxT+Dg6JVEUjtfXHtUvf19Lo1yVc2OlYrEBXRLKfHhWsyfC9XiBjwvUbi9CeSvwHitr387pkmOLav963XunpRBDCkFRjx6SHhDVJFJY2vG/d/h5sYtCqrkhtZy64P7HNyPtH737RJ48o2qwjFtaLveoCT7VmzG5oXYGAugANBPcvjcHzURZg9jVfKOf3JZvJr21lJajdPkWV4Xs+a1JgJ+ti3S5Puj2ldzCbbIkqu6gml5Dv1ou53NW5YnPQmqXi3E2TUJdK/n9RZm+Xt1km6MmFgUknSlXN1NQ1ORPPgd2sEgqX9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMs+REJH0rio7KbtS2ndidhTv4HZU/d+u/HK8E3PEJQ=;
 b=BhvXGoSWDxDBAGm5MRg+BDcfaaJiu/83dyjp+l6viyCFRia2Zwx+DT40XPJx1XTWDMU/hiahTLjPa3V8KHtNKTElJpXmzA6hZGYGLRx57ipYOttXaEdJxsccIoMei577SWaqbAqNOQRYND1o9Bai61hG4IZt/7rI6DOEeObrghE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 07:33:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 07:33:37 +0000
Message-ID: <2cee4501-6a4c-401b-9005-a7fe2002008b@prevas.dk>
Date: Tue, 7 Nov 2023 08:33:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
 <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
 <7b7878a9-c0dd-4d3b-b888-2a6a190109f2@prevas.dk>
 <3c84d65a-fe72-8fe1-6f64-7065889641ea@gmail.com>
 <ea2c1a57-be87-42b7-be72-04599949b445@prevas.dk>
In-Reply-To: <ea2c1a57-be87-42b7-be72-04599949b445@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0032.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 736488a1-cecd-46b7-a5ea-08dbdf63dada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIH3OPriRFl7Ms0JL3HlAFjkbg+nL0tjqsFhT6a2m40+IkqoB/xXl4xFZ2c42gj6pAD9aGSK7nCP/FwhgO+xykwsqAEs7810JwTXXbeEB1pPaVjIK5ZIhGpvLz0D8ZUPJVOzb0M/VkDWGWdlfwit2jJCYiSg+xUHOMSKam/YHEG3h92zmS1QmTtF7jb0rVq8Hw6unJQIFUxPUlQGbIEqGmU5yP1sieam5CTNkRip+EsNu6ilq2f8bmebxq0+LklF/6FENNc/8+07gsdVB4bo4hGvASO6uOrSdNZRIwWi1nVfPNR8UB2OjMSpgmpRCNIJ1wPdWByQ2N9KxWwEmvUz3d03ClLzDjz4lAmnKhrgeYvnb/JxoLz88Wum5KSAkMteAH8YZgJMF40jwS/xBgIdBzqIKfiikap3km/YAXk57GEPgo/AmyB3LjsRwFFtsxCmv3avukzUKiomZz/1Dk7OLlKUVvy21kzAUTXhP7EPCQVd2E2H0AsaFm/cSsGERC8WTy5L5OJ9mtTwef6eio9iwHZ8qJRaOCXhXUK0RqIuZdrQsQN9ERhGeBL8JEV29bi0cmgbZxHk69P/VpOlTfnWYIFcT3WBtZEijproajXuJ01YC4lVqdidjzPZeRsCB6hnbTyyPzDjFtk+mlRK2yELoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(478600001)(110136005)(66946007)(54906003)(66476007)(66556008)(26005)(6506007)(2616005)(316002)(6512007)(4326008)(8976002)(8676002)(8936002)(2906002)(44832011)(41300700001)(5660300002)(558084003)(36756003)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0VXNEFUL29BVm5uNHU0NkF1cjRQVHhxOXlIMkcxblduV3l6aG11dVd2MWIr?=
 =?utf-8?B?clgzYUt6ZEV1TUVHSlRtSXdIY1NkTWZLT3BJRFNCOGJuMVlEbndUZHlmY2pO?=
 =?utf-8?B?ZDlpZjNxK2ExVFEvd2s5RmVEaW1ibU9wLzRSOGNDYUVrYUxhbHdldjV5Q3VK?=
 =?utf-8?B?bmU3VWFZeVpHamM5Y3lrbWRlUGN3cFJxbjVSSlQ3SmFBK0NFU0RRUTJCQ1Rz?=
 =?utf-8?B?UW96eTJLcUp6T2JHM3kxRkkyelhBa0ZvVEhaNU1RVW1BbDNnQ2RyTlo4dm5a?=
 =?utf-8?B?T2VHUkJ6OUQ3NHRNTjVURlFWazlDV3pCb2ZnYUZKV3QyQ2h3b0thQk53QUpp?=
 =?utf-8?B?QTBVUUZQWm0yenA0TDJ6U3JGL3gwRTdmeXlZdlpXampaY0JJdncxZjBMOWp3?=
 =?utf-8?B?TC95V0Q5TmNiVmdPVTJVdXdYMkhKcEhsbzJTRWVDODBpMU0yMGRFMEwzTkE2?=
 =?utf-8?B?Nzc4RmViaGFpa3Z4QTlkZE1nUmdwVUNmQkxGbENLMWc1bVVpaEJNTXB5TG9Q?=
 =?utf-8?B?Zmc1OEVHcEdTcndvVTdma1Z2V2NoYmJva1FSQW83V3RiU2hwNFplYjBrejlT?=
 =?utf-8?B?clZrWDgxd3dZcENTMmk0VkRheW9PNFF3K1Z5VUpMK1RKanNPS29YZ2pUV2oy?=
 =?utf-8?B?bG14TDMxb2VYeityampRNWNGbU5yUVhhbld6dmFYb3l0RUN5V2lNdjEydHEx?=
 =?utf-8?B?UTczSTBkd0E3NWZMRDU5SW5BSWQ2VDdzM2hUemJSRFd5ZnBMWU1Hc2xlV2lB?=
 =?utf-8?B?U0s3WitHKzJLc2VUdnB1cUhhUTFxbTEwcExtRG5jeDJGNHRXbHRaK2V1UUdP?=
 =?utf-8?B?MkxPZ2huUkxjWWFrSmR0VE1uUk1sRk1XUHhRZTZrQm93N3lnUVl3Y3hEVXBq?=
 =?utf-8?B?U0krQnlFdW54MkhhV0d5a2R0a1dqRWtUbG9zZFMzaU05VVgycEd2NU03NzMw?=
 =?utf-8?B?M0pZdjFmZXpBU3BXNjdnRkdpQlhZMkpRNDI2bVNjSFB0Y0xJdHVLQXBPSmtR?=
 =?utf-8?B?VnQ5QXdtc3dGZHJkdjJuc0cvWGxkWVRRcC8rRG15bnNMN0xRa2RNRko2d0h0?=
 =?utf-8?B?dEZlNXhoVG9OYWFrdFcraVJQZDM1VEEvZW1qdE9IMHYxWmJWZnkrRW91MEhK?=
 =?utf-8?B?eXNvY3BtcHBvNzRYYTJhb0Y5Y1Nhem4zTktqUlk0QUVMWUtoNGNmRkhUZ25K?=
 =?utf-8?B?RnFxN0NCTDVXOEpkVklaRlR4c1pEeWFHSG9QMzhSdkNmSG5Jd0o0M09qeVN2?=
 =?utf-8?B?K1hHS2Vkdm85OUpsdzNobmQ4dGZNQjU5NXM4MmJUclJGdDY5UlgyNjh2NUpK?=
 =?utf-8?B?ZS96QnB0S1RTOFlBY1Brd1NTTk1ycUhucHF5dUNOd01GNW50bXZkS3JXb3o5?=
 =?utf-8?B?aEJNQUtsU0pyK1BvazEwUHpyekl2RUk2R29RY01BcEZ6YVIwM1pFek9DOUkr?=
 =?utf-8?B?ZzUvZCtQazRTd2VlQlBTcWd1MjdlaExIY2xBNkYzOTlRM0xIb1VCWXc2VUg1?=
 =?utf-8?B?cEtMUDRNQXNvdVltKzlvSTJTS2VzZHN1clJOSkd5Mm1mSkdGUXlzTVBkMURi?=
 =?utf-8?B?a3JlMTRoL3VZcUlFaGVmdmNoZE9HN3ltek9LRVJJMStxK09oVWx0NjV0RWI4?=
 =?utf-8?B?blgzZWYrQWRVQWthMDNXUFBvSmNpelVQcnhmOVBPakt3UmgxRlp5VWljRnAr?=
 =?utf-8?B?UXJLNDRjcWROa3p5eUJPUng1QUdpUFZWMGtZV243bXBuMEpCM3RPTGUydGRY?=
 =?utf-8?B?MkFJV1JBMTZyRzc1L3I3ZFYrYlhjNW44SzJrYTFza0xnUUFZTHZaZ2h1dnh4?=
 =?utf-8?B?OFNkd3ZjOFo1V1ZYZ3BlQ0ltUU9uSWRxNFBqbWdhNmFIa2JDOWlYT3dCRUtG?=
 =?utf-8?B?QVZYY0ZmNmJ6YVc5bEtsSFRVREY5RTlvaU9ZQzM1V2pMalNOOFdFLyt2eThk?=
 =?utf-8?B?Z0tBakp5c1hSVDM1enBVK0YzOXQ3cjF4VkFRcG5kdDdkcENpWit5eFU4YU9y?=
 =?utf-8?B?YkdrUW1qVHI5ejN3c3F3M2JwbmdubnFmQnlxQlFNcXdUUklkSXIrVkFNc3N2?=
 =?utf-8?B?REoxQjRFTWdxdTZPUU9ldVg0TjhPVjh6a1VrZE80U1lHc1Y5TmY2dGFMc3Zz?=
 =?utf-8?B?UWRGekxGYzBvdW02NUQ3b1ZjMmN6eXExQ1Q0QkpOSmx4cTZCTzFMbS93WGY2?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 736488a1-cecd-46b7-a5ea-08dbdf63dada
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 07:33:37.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQptuDd7TdfSp4y+k3gH6ul7K6jRKtr4trzWaYkrM1mS9rqeuw1dB29gySlh34bK2jiUCXMwaATrbwYx0m9X2zz2RtIxZtYWUzb5hl3H6JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024
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

On 07/11/2023 08.30, Rasmus Villemoes wrote:

> I'll send a revert to Tom for the prematurely applied fixup.

Oh, I see that's already done. Good.

Rasmus


