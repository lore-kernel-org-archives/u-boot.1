Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6B8C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 13:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969DE88744;
	Tue, 21 May 2024 15:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FB1kJ11H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213148875A; Tue, 21 May 2024 15:21:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09601881A5
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 15:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716297666; x=1747833666;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=z3lcwHKUVXB9Pal5Ijbu8zNeBCZcE/tkshg4PrBEe0I=;
 b=FB1kJ11HPhk/ozCYMk1c80lU+IZ/VWB2K00Qhgyz/S8w2LV+LoJ9XQGy
 H9k+x9iwwmINR/vEUY7Gaju36O6JX3SQ0TLVbpvE5Rb9lqv5XZ6mu7S5d
 hJkrXgAuYrNHuvix/NslW6+gMJ4PTBZPdeqDRH3p4UZF15ilVNVR1JSRj
 A6eqq6c9uSHmdgEEPkKlUckNmXT1FJHCD55m56u+NRVDUn71EzEsIOZvh
 JQNzTwmzT8W5P84d7vebgky1AlIkklLrcMSuDBjGxVcZS23J3FKMvtrwZ
 VK7aU7r0O652AKh+dPfU8SmPBypghWliaVAgZyZ3oX+zU5BNsj3tCEV8q g==;
X-CSE-ConnectionGUID: FW/o3mpuSZi4YbPb0oNkgw==
X-CSE-MsgGUID: YgEAycKzSsS3l9HAFtQCqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23158670"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; d="scan'208";a="23158670"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 06:21:04 -0700
X-CSE-ConnectionGUID: HvddADEqRX6qkejZqTeA2w==
X-CSE-MsgGUID: C5IBPtgZTXygvLDQVrNJAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; d="scan'208";a="32777959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 May 2024 06:21:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 06:21:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 06:21:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 06:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR6a3z8gOgZjpUoWPBlp+PHynoRlJWyG+2WCxyD9pD9eksLvUc/VAraITrcV/a6yyPVogUv2ZuXr3oMtLjW524eUDY5M1YwaNtG0OD3Y1FFwcIFjiOKXyQcIXgGLSWXE4DihtWRhdshtyR7e4IrnMhjkayXbGiNVDNZEBNmtzvQQ1Q9CdnvJ2PPj5LoQ9bRPossUJCZtDkr/oRsej1UhBqhUeJ2+YJqjW0vMdEF72psvxkoua0p8ocQiioLimE85UWwdEgI70ziqcFnigUEo+IwC7z1ZZebeUYDUVIoPyNtsFG9IH0tcIH8tSGq+YHkVNSRc02OlXAJJB2TvDB3hoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWfARLoDIBoxx2GuR1H8CSmIh/ostSFNF2UOWio7HD8=;
 b=i9tsQ27wbKr2Nzwnb8IFlEVfIUFuwt/8y4pE5Y9EDz6DBpShrRsxyhYno2rXpvZVzwQi5yAGAYomeL2QXkgJKc8GpZPIw1irASyUYn9YcBxcwv5cyQvyrx+AjqXz8NpyzeJ9gtLH4YiBTY/KaLvm/KVsAOT2mG0noj7ppK3j46tlxTIJlXmF3YVtOP/yZze2syPQJ9AhKBkQq9C69qliV0kgqYLUXTPbSabUtEQGW8o8/yYIvQvRpxAemwMq2QNIMfTU+MT22yu5l+YQPvXgEtt3W6SwkFWnbvOSwGZenQBqNBYTox9OxTTV3kHvAugN3V06912iut+XCP4Pp6NHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 13:21:01 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:21:01 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQ
Date: Tue, 21 May 2024 13:21:01 +0000
Message-ID: <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|SA2PR11MB5065:EE_
x-ms-office365-filtering-correlation-id: b5206d6e-2681-4554-c44f-08dc7998dc26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?032Ze/wZ0XKUr5LFOtQlFhUFcx1n3gCjBPzfN2aiMxkOwtIQ7THGR6MxTNL1?=
 =?us-ascii?Q?6sHKP5cTSTCNT4KgTJ/eOaPHFJ+FCsRwc+DxkKxrDy5rWmG8bBwXCz5Av2HS?=
 =?us-ascii?Q?k7/OxnwSQt684+3ulDoIoZodp0e+3xEIaHWSn4RBXyC8mrzLTQjtmsOGsg3L?=
 =?us-ascii?Q?Qb295OQHt3iQqHmLOx4fIXye1xcA6nRQKWrLzXUxpQVxSpHlchwsD9S1pJNJ?=
 =?us-ascii?Q?Yg91Jp0P5BwLstBgTyRVSNwacWdUXCG2lO4X1GBLkTAtaQuhxtQHUsRynwhu?=
 =?us-ascii?Q?GOJcOp59RAVhc0NXWf7CcMXF47wOY2uQJSJlSzHNOHW16Vapu6CklYZkhfXc?=
 =?us-ascii?Q?qXd+W5+M1rKx6V4RMzo/lWbLlSYrV5nd1exDBcW7ZasZVmfD/0IWX55O7E6S?=
 =?us-ascii?Q?Nlcf9bEu/UrrT/Siu/Zu/ZG3uI0CgSiTO5d68KOdKvLS4s0PVBaQDAjkzk5O?=
 =?us-ascii?Q?u1ljMB7D4nhzl4/CCUTftP5+9SovA0FmOGuYp5UIwZHg/PMpskcIHClnxtUo?=
 =?us-ascii?Q?n7pNYwwfdCy4d7vb3Cs4TdwDKK42u0+GX2dNj5SoPVOCfKK+RdIVl6okuq6v?=
 =?us-ascii?Q?3fnJkERg3OFx9oQwtOjD2jB15qCXU8XFP42z5/Y2pepkmBJnUzXZev5vTqUB?=
 =?us-ascii?Q?qTW1w3YAWVtMu0nm2AQ448l4yv0WFT+/lCp2XjDp5a0FnBVYA7/RzwNq/4cc?=
 =?us-ascii?Q?37cCZISjzd752iIKFckQM6T3i5S65nOS/ti189eMCrVF3vLvCNMoo7jZlK4d?=
 =?us-ascii?Q?/EZyYNuoIdci2CDD9Pz75z7K85C0p5nrx/Q0LRaVGB0M2TOkfuAgUF6VvEwM?=
 =?us-ascii?Q?Lm76dKdyo6oOWGYvL2qQr83OLGhfIG11JUZl/lX9MGIwWDekRr5Zt9ntEq+x?=
 =?us-ascii?Q?W2BuH9VIbrNZ8uTdMfdJdQzyBP2/yB/+3m9Zdtf10sOjZEwHd5geE42KkW9h?=
 =?us-ascii?Q?yUxlc72ogEJOnzq3x4aTEgHGCz0IP+VG9k3aPC2vLjgMWM7ejo8stEL8uuMg?=
 =?us-ascii?Q?W/Enk7DgPNCHAJw5Er04FPNtmcVkbpbWqZxRA4pMLPZ6jAmyheCCiFjXBG01?=
 =?us-ascii?Q?sV6jtgIW2Majenle5a75Klskc7zPGs/7fgiPVPaGTdg03V8pJDPmulgtKoqw?=
 =?us-ascii?Q?eVsP56ll10PLAfTRTzYZKKxzxE9GvzfxIRa4329lgwkPYfu/D7R2C2VY892z?=
 =?us-ascii?Q?cyyQJVPDtQSkY3LHHJxTj3muW7GdTPuOrkikZU6pIH36m0Y7tT4HJ9Wy58Vj?=
 =?us-ascii?Q?4RF+1ubKTNKyr5GAE0MTjMXxHW7EWRxchu1n3Dh5TA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGIZsfp6AgT/aWUX8L5DNYjNtLZVqAaSl+b7vgzEGrAoxzuSkEU+vXg3Qkjj?=
 =?us-ascii?Q?04p2uh/+31x9NBHagfeOq7kbVi9uM4643bh2EylAHaUMzDT9YIXgwB/ODAW+?=
 =?us-ascii?Q?o7iQdz2/kox1TpMv4+P1+dnSeB0kR2eMr+vOZygJeu5cnWz492p1FBGvGnh9?=
 =?us-ascii?Q?4ypgl8m4tzDael671As4m3ja2lO93DspaqW5H/HS5VjHVUvez7vzwTDPSQ6N?=
 =?us-ascii?Q?DVKrw6HsScobwkfR/zzAbG9uYhjKf+hCEF/3YBP3wKX2lfaVkI373fCAuIkd?=
 =?us-ascii?Q?S62qeEjwrquHQn0823ELc2fdHbpAWe3f3ORt1S4fgxqLH9jr/N2e2K/Q7awx?=
 =?us-ascii?Q?jA+7/rmcKdDRMgd3uMJueTDBBgXylZv8mJ9ELgqukxdzAaoyS0iBQ/7RGPHo?=
 =?us-ascii?Q?Qrkhr90FhgGDGLYM96j5VBW/GeS8tjqqkFK1zbkI2VH+FwrEvYlZvTCO14Ii?=
 =?us-ascii?Q?zfrDOOmvCUiXIG3900AA0WvTvmQsJlKafF3lf8k+e1wESw7KEUn4mSG8DE31?=
 =?us-ascii?Q?Uvhj02SC85XJ47s7OS+dhhoUwuEhRhBn4cWSGzVfh4wxNqvxdW+G7AHhd0QE?=
 =?us-ascii?Q?Em9NOLu0N9QiwKZKxVm5gSLh/51sxkSBhV7gCxIyhu69+oYYKP2EMtXw4OOP?=
 =?us-ascii?Q?XFueRxQSIQprFJwPYflre979kf5arew0I3aJYITRjrGFwUi21BwqgG7/BDbg?=
 =?us-ascii?Q?wcE/t7wZdAxO5DcuxiyC/m+EwDowdDi3cmQqwkIVX7J8g1Omx+/6OWQINzyG?=
 =?us-ascii?Q?3X2qeJrwy2OCFxJUvOLvebtQ9Q9jr8lMyKSZ6U+EjKOSyKaa1eoEk0Zv3ckG?=
 =?us-ascii?Q?NWPUOE2TAGbGO48A2RziPn6qerAIAwgFqwfz/tE4jp2CJUH9z27/Q6YtMW17?=
 =?us-ascii?Q?PKvYDMqlJSwit2glkL7l4RUy4d3q4HMgnfP6BmG8uLEHArgca8IIpwui7CPv?=
 =?us-ascii?Q?OZs6U4Z2CkRkFjviS1yvF+cPX+S5993j7I2kN39cFKndLs+9iVNWLm5axjJI?=
 =?us-ascii?Q?RAb5YO95NflS/Ah871q4GX1lQiSxT+oESDcECXsg28qfO66mGG1XaIk7JyYe?=
 =?us-ascii?Q?GjdaWjYnsRMnq4wabmAjuyNdlWcxPWLMBDjF0/oA6rrnOMVa4vOM62md6112?=
 =?us-ascii?Q?Ym0r6ZaX/5v5zXQmQWF842WSfjstXMS5cahH4Mw1aQ77846ztmMUUbXFuN7p?=
 =?us-ascii?Q?PDbpRbayoW0BXs3iIaZUgGHgcrk8zRUu1h7Woj/4Ew7ef94rlSlIy239Bgux?=
 =?us-ascii?Q?6nlwz7dCyhdoKpMbyYtb6jFq1cJIZbxtwgGj0WLuHipbUX/VK9CS1vCtUMg7?=
 =?us-ascii?Q?1XX7dq6YVI1n05qAIeUkGNjJfVQJf6YX76Q9FsvI4KAdc1FjSr6fKp57hGjN?=
 =?us-ascii?Q?UPDXplPw7j7z7SdEwnym5RlEgRkEOAuHUG4686yc3vKRbjC7pOBYvHVQ8EHw?=
 =?us-ascii?Q?q8HFdZlTtE0z46x0uLjlgPB6cjxLWvJ7V9jXdvbNUYwi2D1h45SNYUyHpSX8?=
 =?us-ascii?Q?AlQNFcKpjTOTBjENphw63iJfN3rb69z32h++A2jaY0bJKiuY65cwnNYbghh1?=
 =?us-ascii?Q?wAPLoSMJ8pyuZgivJhs7K28g8/KAcNcuGv8EB7jE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5206d6e-2681-4554-c44f-08dc7998dc26
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:21:01.4745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /e3BvAxxBZyb3Jx4yfvQgmj+WTFbd2/coTDiVVUkWVG5BwYqO54SnY8pKZLDsmEt+wIHR+sGmn44Sd1Xao3OaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-OriginatorOrg: intel.com
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

Adding Tom Rini.=20

Any update from others?

-----Original Message-----
From: Brunham, Kalen <kalen.brunham@intel.com>=20
Sent: Friday, May 17, 2024 3:14 PM
To: U-Boot@lists.denx.de
Subject: [PATCH 1/1] Added arm64 assembly for examples/api crt0

I've encountered a problem when compiling the 'examples/api' directory for =
ARM64 in U-boot. The problem lies in the assembly code in 'examples/api/crt=
0.S' where the current CONFIG_ARM code is only 32-bit. When targeting ARM64=
, a 64-bit version is necessary.

I have proposed a fix by including a 'CONFIG_ARM64' section in the assembly=
 code as shown below.  These changes have been check via https://github.com=
/u-boot/u-boot/pull/538.

Feedback is welcome.

---
examples/api/crt0.S | 15 +++++++++++++++
1 file changed, 15 insertions(+)

diff --git a/examples/api/crt0.S b/examples/api/crt0.S index 57bba9d851..4c=
23a54b21 100644
--- a/examples/api/crt0.S
+++ b/examples/api/crt0.S
@@ -24,6 +24,21 @@ syscall:
                mtctr     %r11
                bctr

+#elif defined(CONFIG_ARM64)
+
+              .text
+              .globl _start
+_start:
+              ldr           ip0, =3Dsearch_hint
+              str           sp_el2, [ip0]
+              b             main
+
+
+              .globl syscall
+syscall:
+              ldr           ip0, =3Dsyscall_ptr
+              ldr           pc_el2, [ip0]
+
#elif defined(CONFIG_ARM)

               .text
--

Signed-off-by: Kalen Brunham <kalen.brunham@intel.com>


