Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830DFC83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1408188C6A;
	Thu, 29 Aug 2024 17:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="N1hsgtPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F60F88C73; Thu, 29 Aug 2024 17:06:42 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992DA88C37
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oliver.Gaskell@analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEASfi022180;
 Thu, 29 Aug 2024 11:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=4Xqag
 4+VXx6JjQxFdRKXjwxc72UHKgmms+owI5GTwbU=; b=N1hsgtPkgSRqDyfGwY0dZ
 4JvRmUU2e95FxVZUwTA6j09DeTOFikpVjPmbuBrgAybk1YSzfXFoaBDK/drzsGAd
 ht80d5LQwiva1gRS4B2LaMfIhv2dXGOIlBXE++HJSSeRo4LMBdlMTYf6usn7KDIe
 Nod13OfD6fFx9NK9VnUfHe3e+OlxTrKlkggjU51WHrKs9xcT8WBnqmNQ4Uq+VYFv
 wesX3F50we0oYRGEh2ytRzJOx3ZbAw3qEt/HY1++qPOii+zw1OUEodVkpxIlqesO
 JqWURhq6/MWK3m87PYzBCJ1MtytFYE2ihxxkKbgio+pg8d6ulypVOWinoHGCkXP9
 w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41ath488b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 11:06:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7ZAoVMx9j9qrjMhKOW5d+j44RgEDASi/mtV2pfxZi/WTcCKzllytfYTqN1OcqbiRmy+ZlkNP/a34/atvnSWHU2pVj98d9cV4whWmuwtNKS8/w6xjFswRl89j+2GzEDvzNlw7ezsXZND39UWYfzLi9pItau3nJtP0roqL97RrYBPEY/AjwyktNyCEf/FBD5U5UB6vN4iWSlaB2RzmNiQQrWd43eN5tROyqfBVSsXd3to5yDUwGoCSE4iquAJMMj+VbDmOT8ICKBe8BFUB+8OnqAqalOr4Hx4B+UyykeaCBwTY0lpijUqIG7/mCoHMZZJtSUemFLvo4u2vd+2KWXm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xqag4+VXx6JjQxFdRKXjwxc72UHKgmms+owI5GTwbU=;
 b=pZSvDzgckgsSiqV4RV0bVQGwA6Naz7TUyAcad8AHNFY5UWuFilDvO9QqbAQmu+pDQydgU8rw4n0yCr60JGmVX2s2N1g1wj+VWthID8OMn4Y6+K1y+FOAgd8rJi4jDxYG7VOs6e2NudlDtS8oKKrtbnlIp9EoEKtbc4iJvKjgetvMru9bPgstExGLazenxUj9X/njScKKoLabLNo6rK7z6y/tmqwWGk2RPBvHJtTAUXcE2CkoNVK/9hn7AodzBLmBEjNQceZqMW/VKRUI8uq1d88PmnfKArIffPPX4I6+6gWYQBgWCpNKAJaIz/VZ0Cs/9d1/bVyvJRBpFB0BYxSkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN7PR03MB7275.namprd03.prod.outlook.com (2603:10b6:806:2e8::11)
 by SA1PR03MB7124.namprd03.prod.outlook.com (2603:10b6:806:33a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 15:06:32 +0000
Received: from SN7PR03MB7275.namprd03.prod.outlook.com
 ([fe80::31cc:7df5:65bc:7a7c]) by SN7PR03MB7275.namprd03.prod.outlook.com
 ([fe80::31cc:7df5:65bc:7a7c%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:06:31 +0000
From: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
To: Tom Rini <trini@konsulko.com>
CC: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Greg Malysa
 <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>,
 "Bimpikas, Vasileios" <Vasileios.Bimpikas@analog.com>, "Agarwal, Utsav"
 <Utsav.Agarwal@analog.com>, "Artamonovs, Arturs"
 <Arturs.Artamonovs@analog.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Linux Factory <adsp-linux@analog.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: RE: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx boards
Thread-Topic: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx
 boards
Thread-Index: AQHa+TLM+4kDAEwD0kOdcGvZyQfyQbI+U4eAgAAD41A=
Date: Thu, 29 Aug 2024 15:06:31 +0000
Message-ID: <SN7PR03MB72754C566D3532701567AC38E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
 <20240829145143.GA2479150@bill-the-cat>
In-Reply-To: <20240829145143.GA2479150@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG9n?=
 =?us-ascii?Q?YXNrZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDQ5YTk5ZTUtNjYxOC0xMWVmLWEw?=
 =?us-ascii?Q?MzEtNzQ3ODI3ZWE2MDUwXGFtZS10ZXN0XDQ0OWE5OWU3LTY2MTgtMTFlZi1h?=
 =?us-ascii?Q?MDMxLTc0NzgyN2VhNjA1MGJvZHkudHh0IiBzej0iNDQxMiIgdD0iMTMzNjk0?=
 =?us-ascii?Q?MTc1OTA0ODY1NjQwIiBoPSJyS243SW1VbGRybFdnWXZ0NFA2bkJ0Q2dKL0k9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQUJvSFZrSEpmcmFBVnE2UVl0RlJLMFZXcnBCaTBWRXJSVURBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-rorf: true
x-dg-refone: Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7275:EE_|SA1PR03MB7124:EE_
x-ms-office365-filtering-correlation-id: ede16b87-daf9-4e0c-ae3b-08dcc83c2a9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JohX1llN3oR72KHM9Iy26aVtWOk5AaRpQRLSYPSZX9AC5xiV4u17TscgeH3C?=
 =?us-ascii?Q?z2ZnrEtcOM4cFmi8fOvDG2tgJ1PBytJq11Hn1Y1oWVGvnTpthrj7C+Cba9ej?=
 =?us-ascii?Q?oRFnmMX0+70eejUzWeGGGoYObyXiDJnDVcl6aX3t9SzVImKbEBZLpUq679A2?=
 =?us-ascii?Q?XhplM9fjUr+SmcDHxWIXBx2eN+yYGkIT2NPDI6XoOFBKfG+4AaihXz11gj7I?=
 =?us-ascii?Q?srYnQ6YY5SrOCBuWXnRV6lmB4taGE+G8j4qGl6RZdbhE+6e448HnpnOy7Nw3?=
 =?us-ascii?Q?Dr4xBVMTrQheTU/DLKS6h4RckGKwEv+y/RegQyaCAtViw+V6faF2h6EcVwbL?=
 =?us-ascii?Q?w940Fx5wnkGTr2PE6B+NW7FWczHcZso9vzIC02HsIcZZ2HaiMv8Nktb7DjCz?=
 =?us-ascii?Q?hf+zTxapNhu/l3oczyLZRuMveiEs95CsIKPenrpIteLekBZFwqQ+kTnX+LYm?=
 =?us-ascii?Q?TCoOn19Ebu/W/NYvxcqZRiP7NPEGYepLPvBVvrBqoyg5+6X/QRq6W54fiWY6?=
 =?us-ascii?Q?zxHzNAIkL1tJUz72qV+RGsTbll4fls3v3/D34jZHWg17Bovx6lZgCMlHkT6Z?=
 =?us-ascii?Q?BLAHAxnbiRCF9wkubgOq4rNZNlm+iJeXP+QZCtAJBQ5nOSffPuZktba4+XN6?=
 =?us-ascii?Q?onbfIiniW4I+LASrDlhfZWFHO6ce53ilcuuM5vjSqM1kdQaTyvPYwgkyT1Tp?=
 =?us-ascii?Q?gnQNYhAVCz5uXnCXuL3dvJpAwwVgiTu7+RoY9VbHFQGLvJ5VGEqmUqCOBxM2?=
 =?us-ascii?Q?NdvItPWCQtFn7gFsLk3iyoDbV4CPATxjGREDVp4UVPUw+ewmAL55tWhhrd7o?=
 =?us-ascii?Q?AUr+sVkxLa50wUjxuMnRmgds/BT5JeOl/UmIeafbpQPWgmCHw+DgXy0LKWnn?=
 =?us-ascii?Q?CPeNT8fDS7HHVl+TTZisA+OZQGoU2E6jz+17W7wVKwTDaHlbfXA1qu+FVp5/?=
 =?us-ascii?Q?AMgJhQ9qocG5eSS+DfTGw2mCWzBjDzaYVU6jWdKOVoQyG/SGEl4tAidXKXpM?=
 =?us-ascii?Q?XIPtdhw5bFKoYwTvBnJrNtoyL06M+Ad288+SWfXdAGpqds3gvJgubxOGF5th?=
 =?us-ascii?Q?MelTT+sQ8Wc9LmfsP96Lkgy+yFBqr2VbulsF68cEYXbCEbIPGoeUKzFlrMcj?=
 =?us-ascii?Q?+Xgu9WD37XvypNAOTF4xEVLV6jNnvcgdmGs9AyPGwV91aYtCtDTpzWeCTCWR?=
 =?us-ascii?Q?L4Eg+8L47SlZSfUNSqKd8hPZT5NRynn5P10SkZfx6CCMbPmEK2uhuqHgj0Nq?=
 =?us-ascii?Q?iqcC6ypuYDxlKbjOdCS5MH2ja8UPx4ORm74TptwPrGrQKzrIsrJ//b4MteOq?=
 =?us-ascii?Q?0EOXfhxVbsM1a9327SlYec5cxIkrh4KIWzpq1CmAYtUEg7CvqCpQr3TnaBRS?=
 =?us-ascii?Q?5OnyOyQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR03MB7275.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zjttxaamfI8XRiXm/08+UlOF6PbciWz+4IBIrvWrlQw8skdtaHWxui6Ch2W5?=
 =?us-ascii?Q?r5MyRvBgFBB4vWGlpTnM9m7XUYUHYKVtGiIOzA8Be8Sv2HWIs8GaY1NYn5tW?=
 =?us-ascii?Q?LOhh3Kj9Oets1UaZqtNzwvjioO/EIGRqrGrk8PivKYZW7dye+x71bwAw6Ag8?=
 =?us-ascii?Q?V4YGtL3YtFtx8lVzn/jeeEe5f2YkRB860NOJ+AUY0EzPIuQxrpgy4yMvHl80?=
 =?us-ascii?Q?NlO5w1+zyvwk1ZY0rWstQygpU4NmLFSSBJs7owjCRfwCs3mDMS/G5Ukx9/qJ?=
 =?us-ascii?Q?PYex8FsOgiRkIClp6MbS1iTf94KTgy3mV0erp9zeRn0zffqU/BE9lURJk+RS?=
 =?us-ascii?Q?S5X6ie6k9kANETGBEx/bfy91z5Alu8rQDC+P5AF1bOkmLHX1PzG3YVfpw0Rq?=
 =?us-ascii?Q?xQj2Z3BfSvXhqJL7mnCPqO4NPpc576iwXh9WZURr06VhEb7sQgwxhFGrfJnJ?=
 =?us-ascii?Q?bC+NyzOhmbeXTmO/Ncknz8Kkm5jGJF4FhUzoY05yrukLADgLqu/AG/1vmoOC?=
 =?us-ascii?Q?2VH2912Rnd46yxu7Go7OTj3z3vNAQgw+QsE0gVKm1rfInFZhaz+9QBnDuJTT?=
 =?us-ascii?Q?+pgvMtCqK7tZGw/sI5CGdP5vuXFfwCQoZUnoEpD5iiDyC7JRb/l70Bmgth2t?=
 =?us-ascii?Q?s7HOUoqkrDAyH9mwEN9Tu8Hjz8d+Xbi2xaKmRFGa3xvrYU69ReMRFmpUzBXy?=
 =?us-ascii?Q?Koe1F7gKwUR6AwZ98Hd1NbWAMTanWXx2M9/neJXObwEHcWfTk8w29B9ijL8Q?=
 =?us-ascii?Q?rtut/8Whi6AfVjE+72gfIBEtCZzRRCnYX/0Gp5JwRqka9Xb3xNujLWraJFOV?=
 =?us-ascii?Q?k9rQWQILvfgSRW6vkQZgA70kwOYYQAk+g3tH6kA/ySSlMYxLENqS4q/9KRp5?=
 =?us-ascii?Q?Lrzff/hGz6lT+qQ0AWXNJYUI67AM4Y3IC4qDRdKAWBKjfWhbxkb9QXnxe22E?=
 =?us-ascii?Q?MiAgyiVBLjhjBZ6L3nWyXynxCPqzXA9UCwlBhpNglou0KWd5bPk5CKfoXd6x?=
 =?us-ascii?Q?DaSZfd+wVEr5oOcQ1+P1mkV1kpbsKWOFHVqcBol+rF0HdTIU0qRXS0caCx/p?=
 =?us-ascii?Q?RgTmxeJpIXw0dWwYkBTrgyRJqb3YecvavpKY0Goiw59afHdxG9URj9QtjPun?=
 =?us-ascii?Q?UVRVXQX9lN00JsFrLBpKXsNtHUW+h09Via/cNpqKeClJ8pGyrLHccQxB0zah?=
 =?us-ascii?Q?opnYEVol7u3XpBkKNlXPwr+6Z36Q+OlZUYDOt9XdFxSp45nKNe7ucmRUpLqW?=
 =?us-ascii?Q?gtB9lIWTtqRGJ7+AkL3vw/r4QoCy3IBW6Z6UFb6Mmre5y8AhWpZKVdoAKPac?=
 =?us-ascii?Q?OFLovUuk79aKS1jlfkH0EWY3kqcWimeEymGAM8/CnwpqWR6djkaNSq/B3s5v?=
 =?us-ascii?Q?Zy6OlhYPcPl1ekHLWOPQhIHQUWj0FAaZoKxMuautJiuqVGhr4HpsvCPNRjgo?=
 =?us-ascii?Q?MZuwfFmD5PP1oCBezgCGZVvxS6sKe8q7TUxi65JMyoP9IEZHrBABKd3hC3ib?=
 =?us-ascii?Q?csw70qtXDdT2iwLCqgvRW5jD4Apei+73UcsoBRko8rbRiXwOUaeqRQSIdKN1?=
 =?us-ascii?Q?gvkyKKho5Oem5wOm0bRJMm28W/qDoSvZf3nBnzZF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede16b87-daf9-4e0c-ae3b-08dcc83c2a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 15:06:31.8245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGTENdeLZM8o91s/E/jl9PT4BikDixF3NzweVXK3ZaefVwi4htI+GQh7zd4HKPm5CugKQzGFPYsRbXsfogld6y7Llg3iA2V0TR9wkIlM8kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7124
X-Proofpoint-GUID: y9oG09nXUKHX9o_dHaWciZ-xVlbRU_TX
X-Proofpoint-ORIG-GUID: y9oG09nXUKHX9o_dHaWciZ-xVlbRU_TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290105
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, August 29, 2024 3:52 PM
> To: Gaskell, Oliver <Oliver.Gaskell@analog.com>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> <Arturs.Artamonovs@analog.com>; Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com>; u-boot@lists.denx.de; Linux Factory
> <adsp-linux@analog.com>; Trevor Woerner <twoerner@gmail.com>
> Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx
> boards
>=20
> [External]
>=20
> On Wed, Aug 28, 2024 at 11:02:08AM +0100, Oliver Gaskell via B4 Relay
> wrote:
> > ADSP-SC5xx is a series of ARM-based DSPs.
> > This comprises the armv7 based SC57x, SC58x and SC594 series, and the
> > armv8 based SC598.
> >
> > This patch series includes configurations, init code, and minimal DTs
> > to enable Analog Devices' evaluation boards for these SoCs to boot
> > through SPL and into U-Boot Proper, as well as devicetree schemas for
> > the added DTs.
> >
> > This patch series depends on ("arm: Add Analog Devices SC5xx Machine
> > Type") (https://lists.denx.de/pipermail/u-boot/2024-April/552043.html)
>=20
> Since that series has been merged since early May, what is this series
> based on top of? It should be based on top of current (or close enough
> to not matter) -next. Also, has everything been passed through
> checkpatch.pl and the results looked at? Thanks.

I made it on top of -rc1, just tested and I think it applies cleanly
to -rc3 and next. Wasn't sure on the policy re. patch series dependencies
so just wanted to be 100% sure that was clear.=20

It has been run through checkpatch, there's a few warnings that I think
are OK. Only warning I missed is about the Co-developed-by tags not
having matching Signed-off-by tags - if this is an issue I can make a v2
that fixes this.

>=20
> --
> Tom

Thanks, Oliver
