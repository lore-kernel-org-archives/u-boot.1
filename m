Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976B606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yXVGutrY;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=SBFsBgHK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23C3A8101C;
	Tue, 24 Nov 2026 13:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYbDjjX5eT69; Tue, 24 Nov 2026 13:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B3808101F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526581;
	b=lvf5ZSoVRcPQYUdG59c3HN6WABf9gRMgO7peM5yj5geRHTGpO08w3cSKaf5/54t0lYpx
	 +MOya3DZofSea+yevOf5n9Gq+g/QXddaWoLagp0A0JJFxf5SjXWzJJFEeCwaGhY4Zg0T9
	 J15n6UAXLT8H/GvzAR2vJsSxFrTQ5Kkh87sZnJlUtQnsJ4NmKeH18ml50Lb6aYUIlf4zD
	 htVJQh3HetSWIoUeBf7/9Zm+UdfaLQr89yqqbE/HAMKbex6C2n6e699RmXgZ9mjjHtYaV
	 d8HmPGnCSvEd+8yQ48bt11yvsckwLOqokauP2fO4MkoMkSmi5cYF99vYdFpjYIuoWMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-traffictypediagnostic:x-ms-publictraffictype:client-request-id:
	 request-id:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fmnChGQPBpYtep49at32ajjAiosuCHnK0wdQ6U7Wgfk=;
	b=axdthSApNyc5Env53IoPj5tHiUhW09J3HhPQPHIqym2FeI+GzTgRu1bvZ8MCH7krbhDG
	 bV5zeFDpUXT0PbPZ55G0jjRMURuE04TwBE4zGa652n5juRje4Do+WlWbfhpkykp9IE6ff
	 sm7kzVOwIbHuuc8yM5Jgp2FZxuhXu+CeTdELWEjeuUI8LD9HHxhIssHC7MpLVRTo6BrAQ
	 sPngZWf8D+Le9Uk6ytEPexsSEY7yUYOjcaLMoyHgg2HHx/mPWFatM5zD3+yUAqdBBu3hZ
	 qbaShVqiqrLaWHApRu9FYDn4TX0hzyLarv31kNKKKgjEGY6QjodhQgJ3VMZc/ysYdoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526581;
	bh=fmnChGQPBpYtep49at32ajjAiosuCHnK0wdQ6U7Wgfk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yXVGutrYqho7hXUDxu+Drjs8ieERHd8hGN53KavGEHxQmtn1XUcgtMlj/4+8xKA0t
	 2b9crZIUJp//HwSvCrOIrz0ZVm+qy+Ms5H5oqpnxpxmgowzI0gB578qfz/3w73PXFE
	 IvaAz8SYViX5+uZcIzren9Dep7ybBBHHPd4W2ooAf0zMgU4GFsNfHyyHnbC1AQdgiI
	 lboB+67coPPX7uOJBdDZPhZCoVGYOklDefjqlRV2c2XnpwN5O6Ij0gPXJcqrq6XyR+
	 17F3cCRNX1CRrhR7C8Jyu2BP5QioF973ofbMOXvBNY53jGZE2b35dH3tzK3TU6YtQz
	 HL2/sz3kN2UOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B3808101F;
	Tue, 24 Nov 2026 13:23:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC3AD1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDDC0607BA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Dpu-1hDJZPG for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12626605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::7;
 helo=tydpr03cu002.outbound.protection.outlook.com;
 envelope-from=jacky_chou@aspeedtech.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com
 header.a=rsa-sha256 header.s=selector1 header.b=SBFsBgHK
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12626605EE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmnChGQPBpYtep49at32ajjAiosuCHnK0wdQ6U7Wgfk=;
 b=SBFsBgHKZzyvf5PENaIvh5ON0Ne72tpO5ROokGSPo9ptSt7lVp8nz1UV+xYpuT8SlUvVZK5J+D3iiJzl7vH7Hq61FZcHqN+0sMqDZ9AO8i13ROgggbRPcfKLYYVhtbZbT31BW36u6w6XFWE7smG7JgqTUizmiSQRyKXttF5JsLg52ndgi2ij6PDCIx/qoL6D+5dUWNu7wFe1iIj9Aki/wrBuY7p0JHRuzaY3QnRSDP5pCEQNkKrBSv6E5iQXM72IJIwLVviMj6RPc4kGx5r0GC536nGHm3X3rbc+2koo61Y7gSEjMBNdsMFxLnvMGpe67GIMtSqqESuehl46e+nSOg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5564.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 08:01:43 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0662.000; Tue, 24 Nov 2026
 08:01:43 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: James Hilliard <james.hilliard1@gmail.com>, BMC-SW
 <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, Macpaul
 Lin <macpaul@andestech.com>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, David Lechner <dlechner@baylibre.com>, Julien
 Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggMi8yXSBuZXQ6IGZ0Z21hYzEwMDogYWxsb3cgY29u?=
 =?utf-8?Q?ventional_PHYs_with_lwIP?=
Thread-Topic: [PATCH 2/2] net: ftgmac100: allow conventional PHYs with lwIP
Thread-Index: AQHde4RktMAAzmBxXEaHRmWkI414prc83MuQ
Date: Tue, 24 Nov 2026 08:01:43 +0000
Message-ID: <SEYPR06MB5134FC272A9AA0D9252525429D442@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261123-submit-lwip-ftgmac100-v1-v1-0-6b34bebaa2de@gmail.com>
 <20261123-submit-lwip-ftgmac100-v1-v1-2-6b34bebaa2de@gmail.com>
In-Reply-To: <20261123-submit-lwip-ftgmac100-v1-v1-2-6b34bebaa2de@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5564:EE_
x-ms-publictraffictype: Email
client-request-id: 697f0c55-4815-4862-a204-f0c73166edd1
request-id: aa441c9a-9773-42d8-b59d-08df4a012da3
x-ms-office365-filtering-correlation-id: aa441c9a-9773-42d8-b59d-08df4a012da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|22082099003|18002099003|3023799007|56012099006|4143699003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|10067099003;
x-microsoft-antispam-message-info: S6+9b6HZcc77R8FrHPeoDzd1Yi4jEzZDrlP88KE1oWBxYJg+4kcQez0CbfhNkekXEaiOVXJ8XsMlFTQ2kbz+8Zu7iKXwI8vLq73c258gyaLLe42t9cnHDuktfpHU0goHleRWyqYYtlxP+PZQQZtHUUFqEv2roM3fcLRsoSu2zvPYcW7+GBDUP4OCPSwAuUuuSm1PiKienZoHTVlO1vic4oOJ/r1HWcobWW6uCKZMJbBV44evxIeez7a4JRnsMM/xL+kvERU7nNNvC4A2/Fcxg34WaroBJw+OQPvUmaj+Rq329U5+KEYuooKKNQQZJlItf4XSMuE5eqy5yIKDfmVsKC6TDzBx4N5LUn/oLeG+KbxqPBp8yizogOCOh+OVYWz0P0H1rC+/ilC+rye5vhDMah5woDeGkDVrOTg1+zG/NJlksU9dFlAKGHYHWcpC7/If0Wf0o/ilehQBssSdF8xoTEeBdVxLPHH4HOr2G35eWiZT6a/Htn5pE+8H3gmgAlOww7SOKtAv9dxz5E/FUMel/+IagFMJFKxyp0S7gYH8T8gPj/3ZM/ngIc6du3xJtNJ2jaAf2RVZdKgcTulF7wc/KIjodDQbdEnF7tZVluTQnNyU+Wl8wmZQhIPhlu2gndpQYnyTFRanynTNyufIri7/RiAoPQuc8Sxi8F9u2KXaS2sJtbyz991+tnfsrU5UTGQLQVdFCFQoZ6qyg9mgTASXPziUrcTyhVcfFHC5lNZtCCA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHV4RlNudVMyditEUHhOSzFZZ1ZwaktYb1RpLzVhNGFkR1ErVnJNMW9aTG5P?=
 =?utf-8?B?M1p6NUVRUU1RTnVDc1FQcHdGa1cvNmJIQURIQ3VxYmdlVkNKNCtSS3AxZk5O?=
 =?utf-8?B?U2RNdmt1eGZsK3d1bUV3NVczWkVlMlJLWkdQQTBUSkpyUE9iSDNwYVNqVWhS?=
 =?utf-8?B?b1JMM1plNjRRQWdQdFZhUUtBbFREeDhhTDhabkxIakprZWxlUXVQeENSVEhR?=
 =?utf-8?B?LzhIZVdaa3dCRSt5L29YNWR4S1UrZXNCbktBRkdmT3dodU9PU3l0Q2FYbndO?=
 =?utf-8?B?ZzVyY1huVUZLamhydStrZ0MvakZkYkQvb011dTRqTVpxRFk3ZVVBYmZqSHpq?=
 =?utf-8?B?MXV5VDdhanNzajBtaUNwV0xZWnkxSmVIeSt5MzZUeDYyYmdweDdHN2tZaE5z?=
 =?utf-8?B?MVpLdkpjdWh4QUhjeXhIVjhkOEhDMUhibk5LK05jejY2dmFvRzJ1bTl5ZW4z?=
 =?utf-8?B?YjloeTNwdU11VzlkemRjbzJUcWI0WUM3VnJiM1RocXBhMW9RSUZhR1RQUnhW?=
 =?utf-8?B?ZVVlenZTS0NGc2lTNHBMRTY4eDVyWDJrcHdHc0xjRU8rR1pTZXRZMHhhVGdL?=
 =?utf-8?B?MzkvUTc1THdNT0R0UGN4cXNGSVVwblg1eFBmVGZXdWxVSUZkTzk5OXByWVZq?=
 =?utf-8?B?UGJ0aGIxaDRhZmxYNE5DUkFJbE9jbjdJekkwVFROeCtUeXpLc0lwTjd5alJE?=
 =?utf-8?B?WlVkQlYraC9ObGhmZFZDV21zMDVhcXFLZHZEekhBVlhWNzRvRGpmcS9VakhG?=
 =?utf-8?B?ZnJHRERYVk53ZU5aSlUxdW5Ldng4bDc4ZWduTGtKbHFsY2xnakFhNTc1UXFl?=
 =?utf-8?B?OXJzc2RQR3pYdnV4RTEzZC9WN0F6SjRob2VMVitiOHV0Wm5rWFZEeldvc29p?=
 =?utf-8?B?U0hJUVllM0hJRFhyMVFiQ1poQ2tsQ2dlaE9jcGh3elZ1TUhlT1Z0dlU2Ymk4?=
 =?utf-8?B?bHJzSEJYaERJenpZWnEyVXg2SzJ3TkVXK2wxSlllREhpaHJ2c3lDenZvUHJB?=
 =?utf-8?B?cHkwWHpSczJNWHFkaXpxQ0c1ZWdwMmhzV0lpeTJzYmduWStFVFZxdStLRHo0?=
 =?utf-8?B?RWJxN0N2ZGRSc0I4ayt0VWVJa05qaUwyR0xkdjU4NU0vbGROcVRiQndicTNs?=
 =?utf-8?B?NTlhL2hBN3FZQ2kwVWpSUElTRmN3OG10M1dlYk9YV1JtbTBkbUJkUHJvWHJU?=
 =?utf-8?B?Y3FXcjhNemFXMnNEd2RDNnkrTHg3TmlmY2tZV3I3dlJFbWhGL0lqWjMxaWIz?=
 =?utf-8?B?TW56VksyUzVoeGtQQ0xNR3hHL2J5MStYYnAxWG5SNEhkNVY5d1cxSVRRVHpM?=
 =?utf-8?B?eUhxV0lVVGczT015Zk9kZXd4bkxacFdIRGlXUFFsa1N6cjBxKzNJdTljanVV?=
 =?utf-8?B?VXJSME9WcE4zVG5CQWhWRzJLRXp1cm90TTYwdDhybWpuZ1Nua0ovdHRETGdD?=
 =?utf-8?B?ZWExWDhvbHJJVG9kOHN6RDNlc3F0cUZySm5nOUhvU2tnOEZ2d1hnTTN0NW5j?=
 =?utf-8?B?SENqRDJlUW1KcUVxM1hLamNQWFBucHoyejRqYjliejBmek1rSngyVXl2VTlX?=
 =?utf-8?B?ZVFXclZvY1ZGNXNNOGx6WEk4N1Z1Y2pQNHNsaWx6WDNualJkd1RDRVRFT0d1?=
 =?utf-8?B?M2ExQmhtZlMzbUlndXZwNGszSUlIdWVMNDE4L3Bqd09xY1ZGbFZxb09wQTE3?=
 =?utf-8?B?NFpjOHByVnpiZkZYQVVJZm5CQnR3YXFuWkJ0SkJyVnEyeHZyMzF1b0RMWTFn?=
 =?utf-8?B?NkdvcDBOdVJjUWYvUHJiMkp1Z0xOaVc3YzZuYWZ5Q1J5ak1FYW1EQ3l2N0R0?=
 =?utf-8?B?cVY3RXBub3JTcnVNbnprclBLbko3bGswc0tWQUZPQXdGVURTa3hONkE1Z2Iz?=
 =?utf-8?B?OUlTb1JSUmtBTjM1VnpZdlduOW56QUtoemY0bnlibE1Pa3pQU0RwWURuKytr?=
 =?utf-8?B?M0RVQURrVSt2YzBheUk0aCswQjNUSjNHMW4zMjg2cEJDT284Z3FNWVh0eGVS?=
 =?utf-8?B?SEdWOTlrNVM4R295SEZhdE9UUm1mcFdRL2RnbzNVWGJ0OXEvY21OeFFFNkZq?=
 =?utf-8?B?N0FvNURSUnRYa210bnZjaEhPdkZjSFdHNDY1MmlsdEg0ZXVOTE5NS3I5SVlo?=
 =?utf-8?B?akhWTFlKZnBLRlpRaEdkT0tXVi9tTEhpdk01SUhmK3Q3cko1d3JPQnVWTUhQ?=
 =?utf-8?B?YVpBWSt4RHN6QVAwRlBCVnExRHVHQkR0cElFb2c0S0FqQ1JRNWFNRThpRmFW?=
 =?utf-8?B?K0VkVVdFSDA0TUNtSjQxUDRybmxsME81K2RhTWxpTktNU1Q4Z0wvWGRwRFh5?=
 =?utf-8?B?amVQcVB5eS9mV3dmSzdqQytleDk4Mk9MNFMxZG5xUmNHMSt6cmROdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l2x9piJUWWbG6wyTXkTRx/G09W1HNp8yhJG7H+LOaSPlM71+Bh6z3vjJAOG6ov5rIuQqUfs1IDK5kZB+ycInTcnDZG6OT/Kkug8OWv0aFeOGbRBrFBnC0IIsvdqLb9oJz3cer737Ywd+hRFKFlKbI4862bO8AU5WcFZRZ6IxzQ57Ig5JhVAZLhwS+y7btN4NjzGEHoIxiv9UQ8jCBNAxqp6x/ENHvS0rXA6/ZTwXfLd8hTwhlBJbtw3J6Icgb4Hsl0jfzBanVNm05Rsj5EB5Jh22hvGbMyiGGlS/kdbeJHw1ry4DZdH5zAD5vl0R4BGqpLirZhyfstvi2QQN8PFvpA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa441c9a-9773-42d8-b59d-08df4a012da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:01:43.0826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeuwRfJNVcAwWqBOqo5ZqSHoqvCXR19+mpTmjgpgSTMuhdh3vh+IXTdKyIQ2kI7LcgQhlSTC1CJy99OwDiJJGOTO3GaU3L986ecjri2IFJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5564
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSmFtZXMsDQoNCj4gU2VsZWN0aW5nIGx3SVAgZGlzYWJsZXMgdGhlIEZUR01BQzEwMCBFdGhl
cm5ldCBkcml2ZXIgZXZlbiBvbiBib2FyZHMgdXNpbmcNCj4gYW4gTURJTyBQSFkuIEl0cyBwYWNr
ZXQgYnVmZmVycyBhbmQgRXRoZXJuZXQgb3BlcmF0aW9ucyBhcmUgYXZhaWxhYmxlIHdpdGgNCj4g
ZWl0aGVyIHN0YWNrLiBSZW1vdmUgdGhlIGxlZ2FjeS1zdGFjayBkZXBlbmRlbmN5Lg0KPiANCj4g
S2VlcCB0aGUgTkMtU0kgaW50ZXJmYWNlIGlkZW50aWZpZXIgYXZhaWxhYmxlIGV2ZW4gd2hlbiB0
aGUgcHJvdG9jb2wgZHJpdmVyIGlzDQo+IGRpc2FibGVkLiBTZWxlY3QgdGhlIG1vZGUgaW4gcGxh
dGZvcm0gZGF0YTogYSB1c2UtbmNzaSBub2RlIG5lZWQgbm90IHNwZWNpZnkNCj4gcGh5LW1vZGUs
IGFuZCBvdmVycmlkaW5nIG9ubHkgdGhlIHByaXZhdGUgbW9kZSBhdCBwcm9iZSBsZWF2ZXMgdGhl
IG5ldHdvcmsNCj4gc3RhY2sgdW5hd2FyZSB0aGF0IGl0IG11c3QgY29uZmlndXJlIE5DLVNJLiBS
ZWplY3Qgc3VjaCBpbnRlcmZhY2VzIGVhcmx5IGlmDQo+IE5DLVNJIHN1cHBvcnQgaXMgZGlzYWJs
ZWQuDQo+IA0KDQpUaGFua3MgZm9yIHRoaXMgc2VyaWVzLCB3ZSBhcHBsaWVkIGl0IHRvIG91ciBB
U1QyNzAwLWJhc2VkIGRvd25zdHJlYW0NCnRyZWUgYW5kIGl0IGJ1aWxkcyBjbGVhbmx5IGZvciBi
b3RoIENPTkZJR19ORVRfTEVHQUNZIGFuZA0KQ09ORklHX05FVF9MV0lQLg0KDQpPbmUgdGhpbmcg
d2UnZCBsaWtlIHRvIGNvbmZpcm06IHdpdGggQ09ORklHX05FVF9MV0lQPXksIHRoZSBuZXcgY2hl
Y2sNCmluIGZ0Z21hYzEwMF9vZl90b19wbGF0KCkNCg0KICAgICAgICBpZiAoIUlTX0VOQUJMRUQo
Q09ORklHX1BIWV9OQ1NJKSAmJg0KICAgICAgICAgICAgcGRhdGEtPnBoeV9pbnRlcmZhY2UgPT0g
UEhZX0lOVEVSRkFDRV9NT0RFX05DU0kpIHsNCiAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwg
Ik5DLVNJIHN1cHBvcnQgaXMgZGlzYWJsZWRcbiIpOw0KICAgICAgICAgICAgICAgIHJldHVybiAt
RU9QTk9UU1VQUDsNCiAgICAgICAgfQ0KDQpwcmV2ZW50cyB0aGUgZHJpdmVyIGZyb20gcHJvYmlu
ZyAob3IgbWlzYmVoYXZpbmcpIG9uIGEgYm9hcmQgdXNpbmcNCiJ1c2UtbmNzaSIsIGJ1dCBpdCBk
b2Vzbid0IGFjdHVhbGx5IHByb3ZpZGUgYSB3b3JraW5nIE5DLVNJIHBhdGggdW5kZXINCmx3SVAu
IEFzIGZhciBhcyB3ZSBjYW4gdGVsbCwgQ09ORklHX1BIWV9OQ1NJIGl0c2VsZiBzdGlsbCBoYXMN
Cg0KICAgICAgICBkZXBlbmRzIG9uIE5FVF9MRUdBQ1kNCg0KaW4gZHJpdmVycy9uZXQvcGh5L0tj
b25maWcsIHNvIGl0IGNhbiBuZXZlciBiZSBlbmFibGVkIHRvZ2V0aGVyIHdpdGgNCk5FVF9MV0lQ
LCBhbmQgcGh5X2Nvbm5lY3QoKSdzIE5DLVNJIHBoeV9kZXZpY2VfY3JlYXRlKCkgcGF0aCBpbg0K
ZHJpdmVycy9uZXQvcGh5L3BoeS5jIGlzIGNvcnJlc3BvbmRpbmdseSB1bnJlYWNoYWJsZS4NCg0K
U28gb3VyIHVuZGVyc3RhbmRpbmcgaXM6IHRoaXMgc2VyaWVzIG9ubHkgYXZvaWRzIGEgaGFyZCBm
YWlsdXJlL2J1aWxkDQpicmVhayBmb3IgTkMtU0kgYm9hcmRzIHVuZGVyIGx3SVAsIGl0IGRvZXMg
bm90IGFkZCBhbnkgd2F5IHRvDQpjb25maWd1cmUgb3IgdXNlIHRoZSBOQy1TSSBQSFkgd2l0aCB0
aGUgbHdJUCBzdGFjay4gSXMgdGhhdCBjb3JyZWN0Pw0KDQpJZiBzbywgaXMgdGhlcmUgYWxyZWFk
eSBhIHNlcGFyYXRlIHBhdGNoIChvciBzZXJpZXMpIGFkZHJlc3NpbmcNCmxpZnRpbmcgdGhlIE5F
VF9MRUdBQ1kgZGVwZW5kZW5jeSBmcm9tIENPTkZJR19QSFlfTkNTSSBhbmQgcG9ydGluZyB0aGUN
Ck5DLVNJIHBoeSBoYW5kbGluZyB0byB3b3JrIHdpdGggbHdJUCBhcyB3ZWxsPyBXZSBoYXZlIEFT
VDI3MDAgYm9hcmRzDQp0aGF0IHJlbHkgb24gTkMtU0kgZm9yIHNpZGViYW5kIG1hbmFnZW1lbnQg
dHJhZmZpYywgc28gd2UnZCBsaWtlIHRvDQprbm93IGlmIHRoaXMgaXMgYWxyZWFkeSBiZWluZyB3
b3JrZWQgb24gZWxzZXdoZXJlIGJlZm9yZSB3ZSBsb29rIGludG8NCml0IG91cnNlbHZlcy4NCg0K
VGhhbmtzLA0KSmFja3kNCg==
