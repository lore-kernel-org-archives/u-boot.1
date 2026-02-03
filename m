Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A1BE83060
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 08:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F828401A;
	Tue,  3 Feb 2026 09:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="iK2YsoTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743268401A; Tue,  3 Feb 2026 09:18:11 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FFA83FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 09:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYuZQtvIfH9dsMRtIvGo5K+29luMyS+pw+h9m78EEN1mccEhTp9m4IdJQvMBN2idqqNzkrXeYJ1663RLXdZVIb+BQyLWZLtkigSDDmP2CUgv1eUR7rKB4SX8qPXMlXnL8Dd4ud49w+Jb6O/fcR8zMruUwssPr5UxQFyuWoyRzqPfSVsUovqnpASSNZQIu4vzJoFti1Lklj56glUsPZflng3lQTCqttYsqHKY6cY8OWNoCUMyIQedUCHtYePK8rGwm/jJRFZ7y0m65tRM+Rd15j+2Zrtb/JjjiQKsu2avhcmR9yEextRJKf9FbRrcahheg4PbsVgARUhXWYWckSKS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBZ2VWZRnc78oC5Y5rih3YAuulup2CU1OQ1bjP9BfsI=;
 b=CM/YmDayBk6P3tsNO4JVJ68Q8MLaZf9ff0qyTvRw9/7mQGBLzt/WQ6DM8SKR3yWVLhGGRzsp/jqMwu3Qu2cJvNRXyTU8N7Ek8E/h+X0lLTsa7XYz27NE+19k1OQODnoK2LNkY56/AXGWGSjM/btR60PTcO492I0Gs/cVs6OxnguKo+OqZNX0M4AC0OA2IV9HkixpiuQMZWuHt1db5YQjA9O7HQ0dghEldazDeI7zxZzu7x3B/V9G4TK9nVKiF/orlGgb38tPEmuxCjgCbk22Vbb4BZBz57IAeDcFphRHA5vvE1jb675hrRGxoYw9OZlqSDh6ZhLW7lH3RXSsoFaHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBZ2VWZRnc78oC5Y5rih3YAuulup2CU1OQ1bjP9BfsI=;
 b=iK2YsoTKxyEzBOzu4TyvHnccWiHGoEccEmsZJG44m0VQC2h5JfDA2rylZl4zCvoybWC3uAKJxYL2wFCpWMW1i40xyUlwFBFVmsFrd/QlwPoMbbl/Is2hvbP7ZAh4zz1Jskuq35jsrnjy0V+vINnwMH2Lhh0kcc14sy6wq+IoTRa4EqPTi9qHBgG//alz7ke2rOpPfdiRHYo7AYF7rtKk1gP4rxuiUR4n2CNx09FH5l3Z+wzjtqQp4AVCwzzvZyemm+unT1JPioTOuETNxz7F1MjLjEJ5fixI0ZiLsfc19PSCKB+ahf4OvMT2rR5ZNNU1d0yRbun1H0hjY7OpIj3ghg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB9355.eurprd03.prod.outlook.com (2603:10a6:150:d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 08:18:04 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 08:18:04 +0000
Date: Tue, 3 Feb 2026 09:17:57 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>, u-boot@lists.denx.de,
 trini@konsulko.com
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
Message-ID: <aYGvNb33Eoozx4zk@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
 <aXDJ4PrbO2eL63B-@mt.com>
 <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
 <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
 <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
 <CAFLszTjH=Yv72oDucXJHyhGrEvtRLRq_7EO8nRd2B2K6TttiRw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjH=Yv72oDucXJHyhGrEvtRLRq_7EO8nRd2B2K6TttiRw@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::23) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV2PR03MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: a29b0606-2f94-4118-b01d-08de62fcc0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Li1pyYu9ShHNnrUAOY57WwiSeI9cO5BfsmVC7tfY9NLgfH1swNpDuBHBVgg?=
 =?us-ascii?Q?icNqCpCW5rfxPRjG6UncSM7jSmQNZK3TVBZD9YZAjGRlN0S5gSgTC0tPIjX2?=
 =?us-ascii?Q?q9sFtZA+0O+KBS+nqbt5m9L7atHF0JKJ1X1pWoTbTADRk3nDZHQ/9w6fqR+X?=
 =?us-ascii?Q?VMSlMNpK47Fyjt7wvUMPhQGzeml8q94IgHw9mIen95EDsBV9bz2Z6Vjr8Ge/?=
 =?us-ascii?Q?RTKCFLUOx50a3GXLCCUnoV8cLweQaof4TXumOPV5opnsPq9NAv8X8X+x2tf+?=
 =?us-ascii?Q?hcIvrKcDvjxM3x2A8CnIpIuanwSCVvkUT+BjkXQTaRm+nPQbf4c4MMRhmlWR?=
 =?us-ascii?Q?/xJmLKF4sciHmKhEGyf8kFaEEgFB8lReyba+I4UwKxBXJHh1X5DaYJD2blFV?=
 =?us-ascii?Q?MMNRyfgFMEckCdsT7nELCuIGXsxafnUUXMCK8ZRm9/1LDvyyV7ipJtSYZCgL?=
 =?us-ascii?Q?MiFif2hEt8Wn5hZDVqy5MU2sB99aTDlL6AW2fWRbf8kM/cf6EwzWTNYd3FtP?=
 =?us-ascii?Q?F5FNM/LAtJXWfX0gb0CQM0qPIRI41SYmU6vOfhbZ7WnqpgC5Q2c+Ig2pqMMD?=
 =?us-ascii?Q?ZyymuHeDlvJrZ3871pECaYQGUJO6/DUdJQRcTp/0r1OpoMmeSwOh6VcRljTV?=
 =?us-ascii?Q?g3nRuJrp+xHkOx4IHzJIFDXkQ3dV+2Jvh/tvd743lng3rF17vBISOTh1ywBH?=
 =?us-ascii?Q?v7k2yC4IAPpFiRxixQZei21LDOP2lz7gBfmVI7ZdmPnPmQNogQMloH8ZjGzd?=
 =?us-ascii?Q?uKH9wHt5jYAjqZUbtK9kPCzFMMZ5apQ1I7h4bhGYwsNvuhaDEO0IiH9IWBQe?=
 =?us-ascii?Q?NO4dP5gqaf/ec+dKLF0fZXlZBb8mQnpe40FugM9mA8ki52ScuDtTfJLTfWgN?=
 =?us-ascii?Q?koNBpYEh4Hvh8I/MEtfv0ds/1O5IlcP/PK7Nsi3/pTNkpF3zwufD2l6EejT6?=
 =?us-ascii?Q?WNZfJKowLfccWdA/FfwfkNKkZ34X5JFlrQvQRPhTTrk0UhCVVhZ9i4mxdn5L?=
 =?us-ascii?Q?W8DOk6a8A6cXulbkpu3vnn0G86Al/Ry60gX8z1sQkembonglUHFc62bhgX//?=
 =?us-ascii?Q?wPm01IqfDrjwFqRpoFhL4uma8pYWhDJ1aTnqxrHYXSOdaWjKVX0Tei9QRF49?=
 =?us-ascii?Q?uKAZbCEQEzXtrD+T+cbRwZtpZPUFjaFJUBHpV9mB5yCwYT03stJ32k010X1I?=
 =?us-ascii?Q?gB11HdeWXwcBKsxFvW6pqW4e2ImfXDuRj2+gzkCxElLauAIOqzwAm6ywPjpN?=
 =?us-ascii?Q?nEkce1X9ox+0z6qFPPVBOlOZy2KyevRk48N2J1tdc9m4k2Q+whzfkUAIa80N?=
 =?us-ascii?Q?jCF0igYwquU7C3sOi2PE1FMiaZCBE44ZQYT5nT+rgtoEtoTShbKAZhNN+n7u?=
 =?us-ascii?Q?Gln4nPjGnKJUlRnZTP7vc1w/60GJsmL6JWFzJ0/HR7P+i1GLz3SyZlNO8BIa?=
 =?us-ascii?Q?3avdEoUmfeKj+q/fb9JJmdyoqNTn/gdQUmzoqNcHvTpia6FsdMRI7AmuaLAP?=
 =?us-ascii?Q?1s8VtN2IliRbymR2Oh7DoBqduFW2e6M0ihf9VuX2jSzq3Mfo69vK7gcAug8s?=
 =?us-ascii?Q?9JS5xYYqKyQM/bRrn2CyeN+iMR0jvWAtoU0uoGIm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/PoKpCi4lGI/6rgOrfcbhf+A4qAX8GXgoFXuVSzHEv2fqMHyp8QxAAY+TP84?=
 =?us-ascii?Q?brCX33j0WFrWpVsx2lrNxLrglqKxEFQycfDAdH9+bdtTl4xVqcspCCyZ9bLS?=
 =?us-ascii?Q?4RfNRxsoS/q11liQtrbulMPXRTvkhE50KE2uPgjf1iMJc2xk65D5g6Qp9xge?=
 =?us-ascii?Q?lkCm3chWni0PliP1qTii37SJhT+fuhf0QYaTgulELOReSFBE0Qtara1LuoWU?=
 =?us-ascii?Q?OtGAUmsc9kTVcyT0N4Vj3M5REc5+BERR/qCXPzP2bhMfTKZ7Ot/rszNbPmRO?=
 =?us-ascii?Q?2k5ygdxPWIIf9MFvFP40WRsOub7Zz4TmPXp2TF/24qxv63De34+M3x1fbJ4X?=
 =?us-ascii?Q?jlm+nUNwLReeTA0UtNNG5/LsgUCgZBWfZ6IzRXrt8nwD83MM+FWGN/QQSw1H?=
 =?us-ascii?Q?gXghqYN+9/3w2b89ivuoT3wQdSQEXnXUlk/QcIPl7DAI5f8vys4pfSDMYZVS?=
 =?us-ascii?Q?AJ/u57OmqNgD26eqThdG1RRrxBhSthmhRfV+bEl2EK5cjDeb8/XGyGcs7eA6?=
 =?us-ascii?Q?+w7BiEReFVTbP07T+ME19or0hFW24EqZWGrTv8naXVGiiHa0Q25xNhk9lDOb?=
 =?us-ascii?Q?FTJVguWSPj/KFxM8Wpfsow7kahokhQBKY3axctrH3rxL66mbNgomRzbKoHMx?=
 =?us-ascii?Q?kyzsotf6heDrmFxJ/hBpm0TWFd6frlME1B1fSIEJFarx9wvzyeEgIa5I5blJ?=
 =?us-ascii?Q?cLyTQ9jlPjUkrbwYnrPKsMfvK+0tKk8LkV343tyhsfEqgG9bFlDG2lq3y2l1?=
 =?us-ascii?Q?uIyLAKkiMVaYsBoMpbuQf36jbWUh5XfrvfU6dfUJeTVMg+NCW26pv9TfU4qC?=
 =?us-ascii?Q?0J/tvxPIU8LvJx5J/zrIDjsn5DbHh36rO5LiEJt8BS1/UEfS0bAnPVueRwoF?=
 =?us-ascii?Q?LXbbQf2KWWf1JwGmKN7Ff0sDztbX83c3ZQ0bhhGmFKczuF0tDZhWyAHka2kQ?=
 =?us-ascii?Q?rCzzAkXbTUBM1yl2ZBnqIvOiKJzHf0daitg0R0UI8BSbI9kB6OPxOLIMG6eW?=
 =?us-ascii?Q?TD/lBkfD1zJWYt79VCkL9LwiCt5/L5BeH43d/MAFg4d0OD+ud0zV0jGsAjjG?=
 =?us-ascii?Q?lj8Y3WcQ+IDKtRqCwBjQHsooJ3SjPbcFjrKa/bFNurJIsa99CrANLVjgyTRf?=
 =?us-ascii?Q?9u2xjk5I2XGej4X6GWGsd7Q/+htw32VmP4im8XqDHM6akeFcxifHItrfo3sH?=
 =?us-ascii?Q?RkJhL2O4xZq7vFEqlHsP+TFL+Kyi6HdOJC8vcTQoeR0WU6qeTk9at08Pxuwi?=
 =?us-ascii?Q?/ONziqwaC3F3mB4CZX8bdDvuSGlrU/2wb991Yp2W3fP1/QMB8EVhLw4wdw9E?=
 =?us-ascii?Q?drNL6RrV/5y+tEox3+vAYWTTRtLc3Ppvcc4/glY9nza5CNHQBeN9LKYHyuIH?=
 =?us-ascii?Q?XmCwuJCDNqUfYFXcogJB2mra+I2kptQjISIqu3vHjkXX2b1PLZdlSKGBFQQK?=
 =?us-ascii?Q?sK9kSIFFxOrh8UqwUzMeahz5zpDNYgOAFqqCLPKpfObc8E6UjGm+pT8yAuzp?=
 =?us-ascii?Q?p4U/qwShnk85XpKfR80rJv2xVHwElab+CVxZBDJ24TNDjmwuzv/JX1Dk1ZXa?=
 =?us-ascii?Q?wDTuVH3F8529XZZPl0B5XbESkhDcxq5lZ1QNDtpw7C+FGxO1apFSotv+A1MI?=
 =?us-ascii?Q?V2xK/hYD/r1am8ajsQD+ENTQv6RT8jwV9EMnMLtfXIOfVYpfKa6lSo7ZcVSV?=
 =?us-ascii?Q?sKNxMTe1CqEOKyaEiynnOxpvRbqT2AplRuvxmufOhYYWFdEo6lpgI/7fjPu1?=
 =?us-ascii?Q?J4TIA1Jp0g=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29b0606-2f94-4118-b01d-08de62fcc0eb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:18:04.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH9nML3sY96szQC5Eaqt7xg1Srx4qaFJXc4JT5SPdLrKJ/a8bT64mUesfRzFq3SXu1AUULeKGa+z5eYTpr9LPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9355
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

On Tue, Jan 27, 2026 at 04:00:44PM +1300, Simon Glass wrote:
Hi Simon,
> Hi Quentin,
> 
> On Tue, 27 Jan 2026 at 00:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >
> > Hi Simon,
> >
> > On 1/22/26 11:46 PM, Simon Glass wrote:
> > > Hi,
> > >
> > > On Thu, 22 Jan 2026 at 02:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >>
> > >> Hi Wojciech,
> > >>
> > >> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
> > >>> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
> > >>> Hello Quentin,
> > >>>> Hi Wojciech,
> > >>>>
> > >>>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> > >> [...]
> > >>>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> > >>>>
> > >>>> This is wrong, you'll be messing up with the environment of all tests being
> > >>>> run in the same thread. You must use the "with
> > >>>> unittest.mock.patch.dict('os.environ'," implementation I used in
> > >>>> testFitSignPKCS11Simple.
> > >>>
> > >>> Well, I have done so in my V2 but has been commented as wrong by the
> > >>> first reviewer. I will restore it back.
> > >>>
> > >>
> > >> Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't
> > >> how we should be doing it.
> > >>
> > >> This is likely fine on its own because there's only one test that is now
> > >> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
> > >> time a test wants to modify it. I actually hit this issue when
> > >> developing the PKCS11 fit signing tests as I had two tests modifying the
> > >> environment.
> > >>
> > >> The only trace of it left is the changelog in
> > >> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/
> > >>
> > >> """
> > >> - fixed issues due to modification of the environment in tests failing
> > >>     other tests, by using unittest.mock.patch.dict() on os.environ as
> > >>     suggested by the unittest.mock doc,
> > >> """
> > >>
> > >> and you can check the diff between the v2 and v3 to check I used to
> > >> modify the env directly but now mock it instead.
> > >>
> > >> Sorry for not catching this, should have answered to Simon in the v2.
> > >
> > > In practice we try to set values for various which are important, so
> > > future tests should explicitly delete the var if needed. But I am OK
> >
> > This is not working. See this very simple example (too lazy to use
> > threading.Lock so synchronization done via time.sleep instead):
> >
> > """
> > #!/usr/bin/env python3
> >
> > import os
> > import time
> > import threading
> >
> >
> > def thread_func(n):
> >      if n == 1:
> >          time.sleep(1)
> >      print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
> >      if n == 1:
> >          time.sleep(1)
> >      print(f'Thread {n} set environ var FOO to foo{n}')
> >      os.environ['FOO'] = f'foo{n}'
> >      if n == 0:
> >          time.sleep(5)
> >      print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
> >      if n == 0:
> >          print(f'Thread {n} removes environ var FOO')
> >          del os.environ["FOO"]
> >      else:
> >          time.sleep(10)
> >          print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
> >
> >
> > threads = []
> >
> > os.environ["FOO"] = "foo"
> >
> > for i in range(0, 2):
> >      t = threading.Thread(target=thread_func, args=(i,))
> >      threads.append(t)
> >
> > for t in threads:
> >      t.start()
> >
> > for t in threads:
> >      t.join()
> >
> > """
> >
> > This results in:
> >
> > """
> > Thread 0 read environ var FOO=foo
> > Thread 0 set environ var FOO to foo0
> > Thread 1 read environ var FOO=foo0
> > Thread 1 set environ var FOO to foo1
> > Thread 1 read environ var FOO=foo1
> > Thread 0 read environ var FOO=foo1
> > Thread 0 removes environ var FOO
> > Thread 1 read environ var FOO=None
> > """
> >
> > You see that modification made to os.environ in a different thread
> > impacts the other threads. A test should definitely NOT modify anything
> > for another test, especially not when it's already running.
> >
> > So now, I implemented mocking instead (like in my tests for PKCS11 in
> > tools/binman/ftest.py) because I know it works.
> >
> > See:
> >
> > """
> > #!/usr/bin/env python3
> >
> > import os
> > import time
> > import threading
> > import unittest.mock
> >
> >
> > def thread_func(n):
> >      if n == 1:
> >          time.sleep(1)
> >      print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
> >      if n == 1:
> >          time.sleep(1)
> >      with unittest.mock.patch.dict('os.environ',
> >                                    {'FOO': f'foo{n}'}):
> >          print(f'Thread {n} set environ var FOO to foo{n}')
> >          if n == 0:
> >              time.sleep(5)
> >          print(f'Thread {n} read mocked environ var
> > FOO={os.environ.get("FOO")}')
> >          if n == 1:
> >              time.sleep(6)
> >      print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
> >
> >
> > threads = []
> >
> > for i in range(0, 2):
> >      t = threading.Thread(target=thread_func, args=(i,))
> >      threads.append(t)
> >
> > for t in threads:
> >      t.start()
> >
> > for t in threads:
> >      t.join()
> > """
> >
> > Lo and behold, it.... does NOT work???????
> >
> > I get:
> >
> > """
> > Thread 0 read environ var FOO=None
> > Thread 0 set environ var FOO to foo0
> > Thread 1 read environ var FOO=foo0
> > Thread 1 set environ var FOO to foo1
> > Thread 1 read mocked environ var FOO=foo1
> > Thread 0 read mocked environ var FOO=foo1
> > Thread 0 read environ var FOO=None
> > Thread 1 read environ var FOO=foo0
> > """
> >
> > I've read that os.environ isn't thread-safe, due to setenv() in glibc
> > not being thread-safe:
> > https://sourceware.org/glibc/manual/latest/html_node/Environment-Access.html#Environment-Access-1
> >
> > """
> > Modifications of environment variables are not allowed in multi-threaded
> > programs.
> > """
> >
> > I'm not sure if this applies to any other Python implementation than
> > CPython? But that is likely the one that most people are using.
> >
> > So... In short, I'm at a loss, no clue how to fix this (if it is even
> > fixable). The obvious answer is "spawn multiple processes instead of
> > multiple threads" but I can guarantee you, you don't want to be going
> > this route as multiprocessing is a lot of headaches in Python. We could
> > have the Python thread spawn a subprocess which has a different
> > environment if we wanted to (via the `env` command for example), but
> > that means not using binman Python API, rather its CLI. We could have
> > bintools accept an environment dict that needs to be passed via the
> > `env` command or the `env` kwargs of subprocess.Popen().
> >
> > Headaches, headaches.
> 
> I would argue that requiring a particular environment var for a test
> is not a great idea. Better to pass an argument through the call stack
> and have the external program run with a new environment containing
> what is needed.
Would it be ok to call softhsm utils with softhsm_conf like
SOFTHSM2_CONF=... softhsm2-util? Then we don't have to mock environment.
I would still have to set SOFTHSM install dir location with the env variable
for mkeficapsule in binman generation. I guess it doesn't affect other
tests as we don't need to change it.

Regards,
Wojtek

> 
> Regards,
> Simon
