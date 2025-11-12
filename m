Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1259CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A14E83C64;
	Wed, 12 Nov 2025 14:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=Honeywell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Honeywell.com header.i=@Honeywell.com header.b="iSrRVIka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39D083C23; Wed, 12 Nov 2025 08:30:40 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA8183C08
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=Honeywell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Wang.Xiujun@Honeywell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRiLHDCtc6JsLeHI8IfZcpire3Oe/pjRzU5iMHZyaFzGsuklFuKBQ4di4/I0aXwqJwS/2yeOthUOQkLabG80sLx2KozY7xCB32OMnklRyYVlcN1Yj13YF+1M/avmHtryplSJhqlTVth5FqLAtukusG8HvLoPBtuGb5Ke5HnLmKuVOjt4G74RkozWwFyErRQN1HvYCTkUrz+SNJWPAIhmhEyjaBjLS0STHt8Rb2K80z3KadPrLsqNtM2b0QsU52PrnyI/KcUrgWtRnhNFa1bhkOr36pTDnJk5Fglsesa7kLluclsH4BMa7TWyT3rT0782RIKkuBEWmVD92kFjcVi33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CqPbHWMbamKIjpTnNTfqTe2EZSOEU9irzqdTWlxeos=;
 b=BTuTNgc3ZmaW4Z335OoWuJRR5mjoHZA8UHTClWYM7Kd0Go46k1WEF62sAGKBCxysg+dtMWSAJMl1NLaQQqZrD7XNYVt+yfeZ+meG85jDLsDise9ELDQG5Trq7prd/WB2QKQTQObgsL12XdkTNGcp0FIYDTuP3vBmS4zcFWklOJph9YLg4pvAHouEFZAj7FSpvFmnbg0QzaY3X46UYdbfnfan0cI78rd94IuH86hIip7W8Ixet/sYkMLiSQDbfpxJc/Epi2J48I/VsDLVyofYFP6ysarXZyS61m8ZYHKiqARyNjRY0gYn3jfGREwK+hI8pc+vlrgJb8oEbEXg883snA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=honeywell.com; dmarc=pass action=none
 header.from=honeywell.com; dkim=pass header.d=honeywell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Honeywell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CqPbHWMbamKIjpTnNTfqTe2EZSOEU9irzqdTWlxeos=;
 b=iSrRVIkaLt/UdwtFrrKTnYmVc94Caq8KNDD3h1d7+StwLSkcTLg1MeEEhcoRUQYqLy1h4+kkUPn9ZYdekgemHhogVLlicHcVOAFIqwcAPn86qB7vbzhLzk7xsb5GYXkmaCGg0KJ7SiMI5ym9s3m3lnVFYo7mndavi9g4zLXLdur5H/UcgCOWjFpj9xLb7UFN/8t0T5l0tzBZQaB6cLhLX91CTHAOP180X2yUZQ3pGxLk0Oxchqm1Q139u4FiMQ8G/TmM6uNIHiA2yxzRAb+Ijew4PEI4G64EYXhYlnFG0RHD4ELwVGT2dLPYy/q/D5iqFd+lXzMNuB9dk7jU1xk1PA==
Received: from CH2PPF49C94B8EF.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::275) by DS7PR07MB7656.namprd07.prod.outlook.com
 (2603:10b6:5:2cf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:30:34 +0000
Received: from CH2PPF49C94B8EF.namprd07.prod.outlook.com
 ([fe80::d731:1633:36f1:4dcb]) by CH2PPF49C94B8EF.namprd07.prod.outlook.com
 ([fe80::d731:1633:36f1:4dcb%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:30:34 +0000
From: "Xiujun, Wang (CSW)" <Wang.Xiujun@Honeywell.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Hi, Dear u-boot lists, who can help answer my questions below about
 device_bind_common in drivers/core/device.c of u-boot? Thanks! 
Thread-Topic: Hi, Dear u-boot lists, who can help answer my questions below
 about device_bind_common in drivers/core/device.c of u-boot? Thanks! 
Thread-Index: AdxTpg9hF1ZUlfCxQgKsWMa6ci9ORQ==
Date: Wed, 12 Nov 2025 07:30:34 +0000
Message-ID: <CH2PPF49C94B8EFB41C012E6E960CBEF704F6CCA@CH2PPF49C94B8EF.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_ActionId=f862aca4-06d0-41a0-84ef-b2a8f0f57541;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_ContentBits=0;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_Enabled=true;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_Method=Standard;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_Name=d546e5e1-5d42-4630-bacd-c69bfdcbd5e8;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_SetDate=2025-11-12T07:19:48Z;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_SiteId=96ece526-9c7d-48b0-8daf-8b93c90a5d18;
 MSIP_Label_d546e5e1-5d42-4630-bacd-c69bfdcbd5e8_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Honeywell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF49C94B8EF:EE_|DS7PR07MB7656:EE_
x-ms-office365-filtering-correlation-id: 9a9ac7a7-9540-4bfc-aaac-08de21bd5e0d
x-antispam: TRUE
x-recptdomain: NotTLSDomain
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5c6o1SaU00WLGPdQUGzY2r2UkkUVSqae3pE/BnalepTmeYofPqDmqdSalYUz?=
 =?us-ascii?Q?URWQ5BFSR7G4NxVCpS5eFvLjTV4oqiiridPCZaR27QnljNWi/iEqlLLeD+MM?=
 =?us-ascii?Q?c9mWbjyUBtUW1fcjpCTVKogaltJ7lpRRT86nIi6pHXAAPvZFSBK3RFx+e5y5?=
 =?us-ascii?Q?tujahEWoO5XET2x8d5xzKRt/4cF34zr3XumM7EiQOxjJz+7Y6TkW4DDdhDAs?=
 =?us-ascii?Q?h+ggDQ00KDyesFqZf4CrF0E1Ptnu/FQIy9ksGXJDYEIhOdEDrWcImZ7PNZ+j?=
 =?us-ascii?Q?FcXH9XwIOubg102Maj6mNQiLX9HBJ2byIRleWyVMT6KvDVbCMIE0/JSh/YZH?=
 =?us-ascii?Q?wLjOunEyeegMgsaJnt8Icrmpx+2J2kULYeoXVYalk8zzDMUKlhaACfhboKah?=
 =?us-ascii?Q?ChKzD4hZbqAodrtpHSQODZuA76eZ/SGNvWmRemGf6g2W7zpMowQzpWytKx8C?=
 =?us-ascii?Q?bpYi5qg7NEymCOAXrfxYxu5EL7e0auH+Ctc/17yjztyrZjBpcMxyUh+MQ/Ot?=
 =?us-ascii?Q?EsUGHt+Wqkky2C1rBxBjo2WDgCAwbhOSLOgvO9OKFgW24ClMIlNkSdl35ZTQ?=
 =?us-ascii?Q?eglvRYH5922KGviZnvucOCej+Nf/S7myl/Y23ls4kQK0rs4bbkXzi5DlfDcW?=
 =?us-ascii?Q?z7uAoyANJQcK3U5J9FEQGjThL5WJ8CZDYw/4CYjBsWH18kDtaoh61mBoYhwp?=
 =?us-ascii?Q?bFT8TTTY2N+HmjvMY0TDP8FSn32gs5bGsdVWY8utjp8zk3CRhGXm800IZzX0?=
 =?us-ascii?Q?up1/jJpw13vkzGoN/kaDqU+xJ9BYO/pf3JQVtdPyhz66UC8YJTD9lopaMzT/?=
 =?us-ascii?Q?STQBSeeqhNdN5DSWyD9TS/iawyFJg2wZuDUTCiZAKRR4zU0jAc6V86Wbwj8X?=
 =?us-ascii?Q?86KVZTWmig9fges+0be63Rl5yG+QwHtijfXNZR0cb9vFaeuZNUB474LgLf7y?=
 =?us-ascii?Q?T//5FU0AQUg+h9LhdeqdFq/18//xwNher6QZnjiflwPmN5zCBSbvT6EdYj50?=
 =?us-ascii?Q?8F86z4VVGkYQ4j3yeU29kXN06tGyzAClLl40kL7yX0v90HhV5akVpbMGMhYm?=
 =?us-ascii?Q?Hmpu72vxKW1oXm7SEjj8pjCdsdIAbn8p2+AxBSu4po6HnRaI/R8OyLb3M60m?=
 =?us-ascii?Q?goCgEYZldqSSWFn29ShYo4213mCUqcHEjpM98NjGj9BxDWkK8u7qGPI4l+Pf?=
 =?us-ascii?Q?3wDGVqxIl4HhQjrbZC/WhrFkLMw+bI8gEdsaJXbUgS2tPeG3OTBIAgXQK/F3?=
 =?us-ascii?Q?MXEv9EF/qUsXvwaUrHh2DQRLbu8HzjCUaFYKOuN1vPDEXjmoR8T0tEoR5YnR?=
 =?us-ascii?Q?htLdtIdzvofCrsUriVmIi/DcZqPsvCJzfWP4If9dL5Mw33+NiD8vhuX+aM/f?=
 =?us-ascii?Q?rynfEii0/gjHaT/4FT6foJOGz2SG1wOh801SLaWbxmbWhHu1KVohmegIzJ6T?=
 =?us-ascii?Q?IGct+SAGAPXVCx7ATye4lL812XljD5hP3fHtyezp7/o4M5tuGl23a3CthbQb?=
 =?us-ascii?Q?WfobOvilfHZ+obAOhCjspPhDobFHN396M4Nh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PPF49C94B8EF.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w0p+NI8Wv1ricBzOTTx7nHv1XxE+p+B82BMsovil7xkU6Yjgamu9P32WFZHR?=
 =?us-ascii?Q?Il0vDWXuIY5OvJKPjCeE6aaEO70fg0w/dceDJ1h0LXcbM7vbNTRMpwYJN/tL?=
 =?us-ascii?Q?9H1j38UEzOD4mxLEbQf+XvrXm7pNMGx5Y3cg4dXfmWtsNo+qFeHDdvWIIdTL?=
 =?us-ascii?Q?XbyU5PqJuxM50delqZf3wLIQ2x4+o7I6+zgqYVcYUL864LFl7WPcOBqJR0cg?=
 =?us-ascii?Q?XvGq+rZtA9ZL0kZAKpUjQD5CiHKoFvQepXc9TG6OKn6ZrfDxiUZ8Z/Lnte4M?=
 =?us-ascii?Q?4JPmBahDTH8l1FQcPlwm4lOePB08piA0B+S7ZfcSBOtGI08ZA6zZdpRAZfgu?=
 =?us-ascii?Q?W/zXveudqqyyJMZgvNjutxMHAvW2LVFeg1OnQKl8fdx/p9ve+B81Dv5XRuQg?=
 =?us-ascii?Q?H2uWn2Rrmb/lVRPVk2CeDLaODuJRRskLn/1JjTVL5dRaRSMgKWWQCjrtZKtK?=
 =?us-ascii?Q?ahVYRqYzW2mZfuK0ZGzj9fGnKDkceUjDhDrhEZ+j5mqa9qb1yrhLd2Ym/YV+?=
 =?us-ascii?Q?kjwK9BpmojxgnFTPIkLob17tj6uELU6ICSKalvgt2VH/zI3B1pTYlqyflBbw?=
 =?us-ascii?Q?GsFxNMn4DeTnLh3RKIxAx3twEdC4hIAmaAPPduk+e70en2FbFWZvIOlZRD7O?=
 =?us-ascii?Q?hIp1Nttbq+E/iCDs5Acf15GeC78VB+mftF2n78Iam3WyIma20m6hFr0g1l5o?=
 =?us-ascii?Q?qA+xB/TiDhuWWRCZlrGklW2hl31sqkcL6nUBhs//hqdCfcT0eiFs9wmSncnt?=
 =?us-ascii?Q?rp/apPxDsetLtz908S3hjHX7vnG0E6eE4g5KHCT6qu+/przB9ImT4xYf6pqo?=
 =?us-ascii?Q?h9j59nFwWYxcTxWNGNPRbSs4V6UOSfX3wCFoduU892/UDDou8xN8PaNNTkx5?=
 =?us-ascii?Q?8HbY80lgUgPpYJeykAsjRh7Znc4Xh7MebPkheGdU30nhL5aGu9y8chs7Orh9?=
 =?us-ascii?Q?/yS0cYDtItYj0AcwziuQVdU/7Ty5kVTKNFFH9DMC08Y4Y3s5D3mBU7pMCoKJ?=
 =?us-ascii?Q?lawsGkjURIXXLXgwrlfK9YiohRJFa83dEBDG+Usc9KDCNaMTMpjCSkQwU4HO?=
 =?us-ascii?Q?1I8OfT85vBSkpj84LQS0+Nn7hQn9P7di4al+6fwirYpfXzArwcXFgsl0K8e/?=
 =?us-ascii?Q?Nu7LzRRUYo30ypzSyvhHjWuSLZW+cfEBEwUq7uyYVsIDR4T2x2M7h96l+Gba?=
 =?us-ascii?Q?kRdXQr9Zu/d+MolpbJiY7DndXIB5mGPaCdXFMHrpyYREEUsRFeU/rBdo87aP?=
 =?us-ascii?Q?ec8wYElKZmN2nitJ2chfRg1UHHwfqFm/CBSv1DBgLKUNHHUduysxHDGrSWVG?=
 =?us-ascii?Q?f9xGG8rrlt2VMEi3ri7QBH4omFVW/rp5iFjMf7Z67N+nXcdKmOuEpCJ7/Vj0?=
 =?us-ascii?Q?Ho2s7xOAbWsLXRBfu8zNXMM4MQcjyIF51Tz4zWFklrtx7r7Oxzl2CQQF+yH4?=
 =?us-ascii?Q?Lb6swXBQnClrvIBcgw40myC0JxZWSV4mdRb2znMUFw1nam61Mgtxr9xeQ3bw?=
 =?us-ascii?Q?mbi7E33Ds5shcxUZ48d2s1xx2DXR2nxptY4shM6rJHXKyNKjZ3Rul23d5evd?=
 =?us-ascii?Q?bzNbbsNuUPGU3G4MWWm6McZ37Qs9l5284rAijAv1?=
MIME-Version: 1.0
X-OriginatorOrg: Honeywell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF49C94B8EF.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9ac7a7-9540-4bfc-aaac-08de21bd5e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:30:34.3167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 96ece526-9c7d-48b0-8daf-8b93c90a5d18
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCRBxWEp/CpDvDk1wOc4CG5q3mQ3DpOmr/YRFRLthzWDSdY16ifvFNTHTLDSOSZwa/GmJ5BAjUUnUj64Lf3qaGiXoZzjRkn5cfVqoZ4UMvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7656
X-Mailman-Approved-At: Wed, 12 Nov 2025 14:12:21 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

1.
Now we are porting rproc diver from NxP to our own u-boot which is based on=
 NXP's v2020.04 version, and we find that if we don't do any changes to the=
 device_bind_common interface in drivers/core/device.c and the rproc driver=
 doesn't work. Then if we add some codes(two red lines below) to the device=
_bind_common interface in drivers/core/device.c and the rproc driver works =
well.
///////////////////////////////////////////////////////////////////////////=
///////////////////////////////////////////////////
static int device_bind_common(struct udevice *parent, const struct driver *=
drv,
                                                 const char *name, void *pl=
atdata,
                                                 ulong driver_data, ofnode =
node,
                                                 uint of_platdata_size, str=
uct udevice **devp)
{
              struct udevice *dev;
              struct uclass *uc;
              int size, ret =3D 0;

              if (devp)
                             *devp =3D NULL;
              if (!name)
                             return -EINVAL;

              ret =3D uclass_get(drv->id, &uc);
              if (ret) {
                             debug("Missing uclass for driver %s\n", drv->n=
ame);
                             return ret;
              }

              dev =3D calloc(1, sizeof(struct udevice));
              if (!dev)
                             return -ENOMEM;

              INIT_LIST_HEAD(&dev->sibling_node);
              INIT_LIST_HEAD(&dev->child_head);
              INIT_LIST_HEAD(&dev->uclass_node);
#ifdef CONFIG_DEVRES
              INIT_LIST_HEAD(&dev->devres_head);
#endif
              dev->platdata =3D platdata;
              dev->driver_data =3D driver_data;
              dev->name =3D name;
              dev->node =3D node;
              dev->parent =3D parent;
              dev->driver =3D drv;
              dev->uclass =3D uc;

              dev->seq =3D -1;
              dev->req_seq =3D -1;
              if (CONFIG_IS_ENABLED(DM_SEQ_ALIAS) &&
                  (uc->uc_drv->flags & DM_UC_FLAG_SEQ_ALIAS)) {
                             /*
                             * Some devices, such as a SPI bus, I2C bus and=
 serial ports
                             * are numbered using aliases.
                             *
                             * This is just a 'requested' sequence, and wil=
l be
                             * resolved (and ->seq updated) when the device=
 is probed.
                             */
                             if (CONFIG_IS_ENABLED(OF_CONTROL) && !CONFIG_I=
S_ENABLED(OF_PLATDATA)) {
                                           if (uc->uc_drv->name && ofnode_v=
alid(node)){
                                                          dev_read_alias_se=
q(dev, &dev->req_seq);
                                                          if (strcmp(dev->n=
ame, "imx8mm-cm4") =3D=3D 0)
                                                                        dev=
->req_seq =3D uclass_find_next_free_req_seq(drv->id);
                                           }
#if CONFIG_IS_ENABLED(OF_PRIOR_STAGE)
                                           if (dev->req_seq =3D=3D -1)
                                                          dev->req_seq =3D
                                                                        ucl=
ass_find_next_free_req_seq(drv->id);
#endif
                             } else {
                                           dev->req_seq =3D uclass_find_nex=
t_free_req_seq(drv->id);
                             }

              }
......
///////////////////////////////////////////////////////////////////////////=
///////////////////////////////////////////////////
My question is why I should add these two lines code.
Note: We have one node in our dts file below.
///////////////////////////////////////////////////////////////////////////=
//////////////////////////////////////////////////
imx8mm-cm4 {
                             compatible =3D "fsl,imx8mm-cm4";
                             syscon =3D <&src>;
              };
///////////////////////////////////////////////////////////////////////////=
//////////////////////////////////////////////////

2.
I notice that device_bind_common in drivers/core/device.c was changed as fo=
llows in v2021.04 version.
///////////////////////////////////////////////////////////////////////////=
/////////////////////////////////////////////////
static int device_bind_common(struct udevice *parent, const struct driver *=
drv,
                                                 const char *name, void *pl=
at,
                                                 ulong driver_data, ofnode =
node,
                                                 uint of_plat_size, struct =
udevice **devp)
{
              struct udevice *dev;
              struct uclass *uc;
              int size, ret =3D 0;
              bool auto_seq =3D true;
              void *ptr;

              if (CONFIG_IS_ENABLED(OF_PLATDATA_NO_BIND))
                             return -ENOSYS;

              if (devp)
                             *devp =3D NULL;
              if (!name)
                             return -EINVAL;

              ret =3D uclass_get(drv->id, &uc);
              if (ret) {
                             dm_warn("Missing uclass for driver %s\n", drv-=
>name);
                             return ret;
              }

              dev =3D calloc(1, sizeof(struct udevice));
              if (!dev)
                             return -ENOMEM;

              INIT_LIST_HEAD(&dev->sibling_node);
              INIT_LIST_HEAD(&dev->child_head);
              INIT_LIST_HEAD(&dev->uclass_node);
#if CONFIG_IS_ENABLED(DEVRES)
              INIT_LIST_HEAD(&dev->devres_head);
#endif
              dev_set_plat(dev, plat);
              dev->driver_data =3D driver_data;
              dev->name =3D name;
              dev_set_ofnode(dev, node);
              dev->parent =3D parent;
              dev->driver =3D drv;
              dev->uclass =3D uc;

              dev->seq_ =3D -1;
              if (CONFIG_IS_ENABLED(DM_SEQ_ALIAS) &&
                  (uc->uc_drv->flags & DM_UC_FLAG_SEQ_ALIAS)) {
                             /*
                             * Some devices, such as a SPI bus, I2C bus and=
 serial ports
                             * are numbered using aliases.
                             */
                             if (CONFIG_IS_ENABLED(OF_CONTROL) &&
                                 !CONFIG_IS_ENABLED(OF_PLATDATA)) {
                                           if (uc->uc_drv->name && ofnode_v=
alid(node)) {
                                                          if (!dev_read_ali=
as_seq(dev, &dev->seq_)) {
                                                                        aut=
o_seq =3D false;
                                                                        log=
_debug("   - seq=3D%d\n", dev->seq_);                      (1)
                                                                        }
                                           }
                             }
              }
              if (auto_seq && !(uc->uc_drv->flags & DM_UC_FLAG_NO_AUTO_SEQ)=
)            (2)
                             dev->seq_ =3D uclass_find_next_free_seq(uc);
                ......
///////////////////////////////////////////////////////////////////////////=
/////////////////////////////////////////////////
My questions are:

  1.  (1) and (2) are mutually exclusive, are they? What I mean is that onl=
y one of them can be executed for scanning and bonding one udevice.
  2.  What is the condition that (2) is executed?
Thanks!


BRs
Xiujun Wang

