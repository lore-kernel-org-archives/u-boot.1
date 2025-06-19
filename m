Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB356C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443F982C65;
	Thu, 19 Jun 2025 18:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="tBXy+x1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2E682CBB; Thu, 19 Jun 2025 18:39:19 +0200 (CEST)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FAB80C83
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVWB6qGpuelsSO7In/3kO4DIODWdyyThkgSo/DIK4KvDVJuzvL+wCbfefassWw6vTQTKiFSUefp/RRmXxSVRYfg6ONdMN/2BfUN9NkU0+AxB68gMvBeCRmBKBzmJildWTKNYxvYyVpBnDO6YcyVpr7Wyor9ZDH/lW8qLThVS4zNJkHhbW27O9yDmpsJzy4auaoNl8t+WO8T+aPfn6DAR0wGPjrLKG9BzFOVzU8kCsJtJj0+7D+5cuS5vDfxO/VzFziiR1Moofw87F4IW/6mgMyIV9XeGJKC4L0pS3pZ1v897D0XO+UPW/5PqGOXWBUdgrZIarrFujrxPgS0Hl2PgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnu4BxjHu1/9Tkc3rfqSSFFz0mR4DbeQp84rYqREZ6E=;
 b=KIL11Kz7rjzYLVvQ5m1S3ieJVXwTsJ1j2PwsIv537HDzjE2sBA6yO1c1UM/LPCJ84CHPGf2KMuodVXGyn5JkonMfeuz8+Z5Xj/VpgU6UrBs7MA4Qh43SSycOkVsqS9Nl6cnbH6eDyb8uzjzNx77Oy+7SQzupmQp0HBpJqut+lhxuDj4txvKJryQ2hAVNzyTCO9ztkn6qOoRk1l54PlNcxv5aKf6fLJTpraz0MRg0vkGSWYpVA35NgAUSHJEfxEyVMCVnphK0mxyqygEZ29NGuB80yl6NXLAJ2irK2Iu9vzA3cjdf+jNc+bv+Y09smOXNy0U7CzVmfe2Wr83l8WrkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnu4BxjHu1/9Tkc3rfqSSFFz0mR4DbeQp84rYqREZ6E=;
 b=tBXy+x1+UAsNCL95OIjcvBBTBPsPluZFM7DQ4dIN3x/QyADpz+8/T4Qs+lf97fLIfYKg2JRKh7QuepQdcLLmp2d3VzD4az1n/T/CslLiN0z+eiNeDzDVvO+9eQ5sFSe9LscxxIjANQAl8oXbKLr4G3mNSi5c7DehYLtm0GELD7wVTtg3p7OhPQ2LwxoLT7vhto0Gvv/XznQJNcFRb8ys9JpFiBlLBys9R9F/m+5QZgjzHlk8RuzNC5QBMr//vSbHfd+17hW/2kbrdl73CkKCgeCX9EuEsjDjQjqaJwnihvhj43iPS7jeemyFeIx9xA34eWsn7c6a/WNHB5sVIHgr3Q==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TY4PR01MB14499.jpnprd01.prod.outlook.com (2603:1096:405:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 16:39:12 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 16:39:12 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Shiji Yang <yangshiji66@qq.com>
Subject: [PATCH 0/2] rsa and fit_check_sign build fix for v2025.07-rc
Date: Fri, 20 Jun 2025 00:38:16 +0800
Message-ID: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250619163818.4021-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TY4PR01MB14499:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f73ae8-4839-4b2c-7f9c-08ddaf4fcf9e
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWw/1Sq6pz4wShrVua6nWkTMENPg10ahArMQ0pgw/q+7wMX1dv+regxfayfDI7a0naXudIl658txVttr5a5T0uBMvPKSjNJJb+GsSY3huO6SPs49UfqQcl3H2T19pcUV/Pve6gCUyDP95/u+52ulH8oEznS9Ca/Zqzw85VFnsWs3FQ5kVAzQUYMS9+UJaqvtcr6HJ87vZ3VNnSkcngNfZPBUZzRaKkccUD0p1YEffcTh7RLg9Ga7vtcE2N7plDx2BNWYX+R1hJsF+ZyPHDrg8Ee7g3gT4f92UTZ54o914Zpr7phGHcAkQzCcmsOO8m5aj0g5ZieTJnI/dKQsNc+6E2vMEKARyW3VmzSsNxzE/THEJ/tx+I1nyudCfULahZiOZ+UeoNy7w3e76prFvquzHqdCZj6EUsiaFqeusEor5U4beGbJZch5tYkeBhVBDX280/gZDxNI+uuPFPHOymYrwfBVTdQGcMLtL4dMeH7UT4Z/XXvMUqsQsJ8932Vfw05dvR7oeJ/nv/jJ/spy1j5K0Hbsf9T+Amc/idhdkNLWl3ZDOKGFjSbwVE6yuY6VlHjFHReM+ffWCgwicKOXkSdokl2s53cOFSsHKUacpxccI0K9BAeC7DqrVqKYWAW9B5DDLNlNCpvQNd8y1qk3VCKp2qh1xcvZYZYvyJskCtdw/2FRFDViblswVL8qlF/kga9hRUzt3R2aQacXmGkzn91+efu1Fcs8XtKEMLUQcLIP/fAlzWO9liu0G1YQIv/El0MaTmBJ42j8yum7Io+vJbD7HZoB0dgxibhUUA=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799006|8060799009|461199028|5062599005|15080799009|7092599006|5072599009|440099028|3412199025|10035399007|40105399003|39105399003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?btp8Gul5jnDEzZU6rM8Q1qFuPGqpkDDBkHl/QXn2gFvk1t9cJBTiwdfyxkkX?=
 =?us-ascii?Q?fsZJEfwSGeI3lzsL1kMSb9icf4wJV5+BZQ4fTac3jEppfBHXMAzU90pPoohc?=
 =?us-ascii?Q?RpyVvt/bU9Q/ndiQf7jcAozyW/nvKwH31bFlLkStSRRHTR1zN4TnsDIdu7j0?=
 =?us-ascii?Q?U8FzPHSO4AW/mjo6PPUDWpo4jSI0e055kkmYvtviqt/9ULlOJRqgPlnkv6sF?=
 =?us-ascii?Q?TqSONZ5Ge3cDxmADsdZG75mUZPB4sNLMXacD4CApZZHk7MeNKKaVucM63ErV?=
 =?us-ascii?Q?WlX836FwKa7x/HlOpCLcjOrMLP4VIbZLfg6NOWedtbmLgwwbmbudkK3KRe3W?=
 =?us-ascii?Q?N6xm9jY2anXzJ0ncyC9nEcgPureQoiVGgKVKlRYVDPCeZLlEwb6snuGE6J1y?=
 =?us-ascii?Q?xN32pcPylQR/+wZuF9uO7DsyCctYG+3jgoOWlOcjdjyvnRmwf72cjPt0JSbT?=
 =?us-ascii?Q?VTgz+IPpgQKlAa5j5yC0JYeBEObZ2C1IdHAhxn3g86sj9I9lXx0TDk7XCPXy?=
 =?us-ascii?Q?oYknT1BsPnV7q1Q6Powm6bHWdE3RoFPPG/H6J0vVM5666pbGTvE8r2jLGGR7?=
 =?us-ascii?Q?J/LbHzhwp7F6bgdnFpWWDjSMdUoqgfMcmcI/XmDBQ2KrgKpJprByZLG2IyA7?=
 =?us-ascii?Q?ITofsDj8n87Psrjqz6M8cbhyapwUjPQEM//PlXVuTGNSH8a450zDSChmVCrz?=
 =?us-ascii?Q?KBdEYtIjSE6eSDyo2cKTjU/xFwOsdXZJMy1d/O10D1SVF8rQqQs3NwBdwxRP?=
 =?us-ascii?Q?QJ4B+p+rOHjXv/SY2DzY/vbmVG3klGMuh0ga86+MYPN8PgwLvOwwSOGqOkTE?=
 =?us-ascii?Q?3sXT7zZqr0ries9LYvGpj8iuItI5lBzX9b8TNx9a0ccBycpCt0r+EoOkKhIG?=
 =?us-ascii?Q?Wop9eRFpRZVpfSIxG5r9dbTtyWC2K5Ys6zIQLpJK2l29Av/bMfvMNJd33Pqe?=
 =?us-ascii?Q?kZONGAQUqXGwxJ8YaoGHzAYTFZSzJYNCUhVSmtcyWG82W7JHJhpKRMU5VLAZ?=
 =?us-ascii?Q?WR7SsowKrDBvWVoOTBlnEZJ1v25PcHyfvqPsP8VBMNdCJw10SVu5s2cN3i/j?=
 =?us-ascii?Q?8gmv0eKDHPWAHFf9nbrE+9gN2D2tRf+4ZgJSv1cC+cmHrBjQaS6h45WbvUfj?=
 =?us-ascii?Q?kOIZuwgroXdQcGs9PEReuZlCauZfVHrwJtds5nxDPS96r2C8M8kPY7Xzpnnv?=
 =?us-ascii?Q?0BUxP5px1bWp4r63OcZ8ANLm+o7lXJVtttaS+Eeuh5tl9EAH8zs5NbSDna+U?=
 =?us-ascii?Q?nQmqQ8ZPgZ1Aw7dCJp5oEHJVdDn+Z67rDnf6Fue93ENr8m3JYyc4CsRm18wS?=
 =?us-ascii?Q?gtPXy4JHh2o/Te/c8tzcqTRz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Khs6wJf5+QFbJtnU2ouf0cFoa/rczZUP5goxZAspd9lO0EDWj+3XCwOlm1XL?=
 =?us-ascii?Q?oBt4QKyiIHWH/PxBxJ/HFmU6WFl1cs4voOBlAGef68fwoF5uF3yfeOx+pkDs?=
 =?us-ascii?Q?0IEWM9TVa3bnC0coFoqOJDLbSBElyHXGNqJ8Vfbi/kdvi2D5iGLjUMJ41Udh?=
 =?us-ascii?Q?eVT1cxsI7U009wbi3zw9aN/ZShAVxEIssLVp+AcBf1877wDNBDtxa1/6roeC?=
 =?us-ascii?Q?FYc2hnlBLCOK7gWirFQRJjntKLMiB79hjR5BWe9/4r6wmp0iDxWVlvnyy5sM?=
 =?us-ascii?Q?7o3CMIT/IsCqc1jBfYd9zaNYFURbfA5XPkmUZYzy9n8jsqOz/IgnN2SbYwgf?=
 =?us-ascii?Q?Ik99b1wzLojHMu5ojbFcwZzLKuUX07YJHAaQx/aalhlxKrta8vWaRJsTiEif?=
 =?us-ascii?Q?zVlXnsBfOZUSWTciwVSq6CieGW1cHsNKn+nI17ejCjRizt0nHX/25FaAZJZr?=
 =?us-ascii?Q?s+uefPSsjyZD+f8vE5ElrKjxN6WFQbOhGcVmluPqrbSZPgpdOh0EZZ6ypwr8?=
 =?us-ascii?Q?xjAZyPpa8liXO5WgW24+y5hdqHn6sFmYPNPmEQJ6LON7tryBG4AOblqugF00?=
 =?us-ascii?Q?igKKOId1atlOuBsHLN48r7yt/wqt9bC20yl19IXhL7M4g4DRT7beNvllCvH2?=
 =?us-ascii?Q?uF09VLgg7bsUrg5ubK4fyD+X6021Qkd/hzkmIdo8nzVdSPJ2Ubknr8n1JixZ?=
 =?us-ascii?Q?ze0whqPl5YR4QPZB9FCtELgJ3RvA7fwwj52RqywhEQTLTTLdqpP+F4+YltQH?=
 =?us-ascii?Q?rB5FlSumITo6sSJribF/d3RICRzohO6AWKaFj33U4gAYsf1KMQVkIGnMMljq?=
 =?us-ascii?Q?5aiBO7dvfsD5aG+5qy6bpbItaLXdMa5rjUhT84WVqoPtvx+WpzznWRvQE1qt?=
 =?us-ascii?Q?vqp/+B7oTtUDImshlfdNmNRx/C1srFxtzRe72cq4IXaKg3Xkm7MDqCeoGeJ6?=
 =?us-ascii?Q?mqh7actW+EB5P268lBYvCS1DLBH4XvshoW5rJZEtOMco46UIMzSOHyA6p5mV?=
 =?us-ascii?Q?JRuyOY/mfz+6Jbv5bX8IZPH6oKmYTvAQGgQJwO2p67JHdhgGFRfGPzkdYVlU?=
 =?us-ascii?Q?bOjGe66xfEHMxANn8Pcti4+uQOZ0XMW6hBXNWMlcq9FJSFD/N+T84U3llorB?=
 =?us-ascii?Q?9/U6EE9TDftuZd1KXkaVlfoWQKN9BB7zqVdgGhIWIrLQsYpwJdKFYPsOHY1e?=
 =?us-ascii?Q?opzqwowBqysd/G/ZHrg+3/3lFg+PCv63ha9Oz72tJal1CEXO3CDJRkrKSO/Z?=
 =?us-ascii?Q?9snvP8YR30PvM9S9msfL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f73ae8-4839-4b2c-7f9c-08ddaf4fcf9e
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:39:12.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14499
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

From: Shiji Yang <yangshiji66@qq.com>

This patchset fixes some compilation errors that I caught in version
v2025.07-rc4 and branch next. If they are acceptable, please apply
them to the master branch. If anyone has a better way to fix these
issues, it's fine to ignore this patchset.

CI test: https://github.com/u-boot/u-boot/pull/783

Shiji Yang (2):
  lib: rsa: fix compilation error without openssl
  tools/fit_check_sign: make the module dependent on
    CONFIG_FIT_SIGNATURE

 include/image.h      | 2 +-
 lib/rsa/rsa-verify.c | 2 +-
 tools/Makefile       | 3 ++-
 tools/image-host.c   | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

Regards,
Shiji Yang

-- 
2.50.0

