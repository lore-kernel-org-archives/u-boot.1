Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7712C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5713286F53;
	Wed, 15 Nov 2023 16:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="naF7KLfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D0F87448; Wed, 15 Nov 2023 16:43:33 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F6886335
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4XPWw3t58Ixp4fDjd73ybyA5s7yEHL7ZfhwLDR2dv/ttjny8hbrzZiU07YtYn9CcqprcLg02R0B69GISg+4uj8+PJIIPdwmrQkJnTT9mAHZtrGl/e2Z0IEXQmNy+Vsb6bhiEnAj7b7EfFYUUzdRRnzdv7Ag5OZ0eW2csoSmKHm3ANJjj1cDbM/G4AF7cGPmiseXb2uUk+parFQJU/GYUCRFdovgVWO3tsELerbcBKgjcKimS1kpTUm4bs9xzFVMVHsNKLb8EzG9Nzx/lOWi3dWYleNmizCwvxDhelZtTICLxQiScnfmlZRVaASQjTE4xUtl1k6nqL1yA0hFokkxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeUIqWimxoI0XPoPkY8d3ODllW10p5exakfC/WbeD64=;
 b=g1o10M0UldhfeQFUrTPtbHmOfUdRF8K1dS8RwTCTdByQ8pn6Mie+YYmL1w+2IahhD0jYJyGOlogzT5N/2d7nvk5tz3or8C+lRBIsuqs5XCvPJ5HuyOHPW6sTIzQkaLKQDYzsh601FGgzFQA+7CAIzMtV8dbWI8d4nN4Dtctk+IQZ4oz19nJ1sb3P0N4P5guCPNFrXCferTGsUB4EghkajB6ymBN7a1YX6Pl6Dnac6E2FQMRsxXNCWQKX7m+McO9bQVrml/aRMR50idnblfgSPXeVvsCf83GZhXS8OeaZW646U2Gi7L6rdkN8+e59mO+QuMaC5r/yWUuSFmDVOM0KsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeUIqWimxoI0XPoPkY8d3ODllW10p5exakfC/WbeD64=;
 b=naF7KLfTm2RMiC7ARGHzjxmRiwrgz6sVVTAUaO2GIyMrE7Q1ssREXbYEh1+Z1NJXtlKfosAaUiOzxAkeCwbW3xykfv5+N/NonSlZQydrI3SuWKY39V0w/PMUVSgAGCUaKreYGl9dsJ9JHjL6W4aIeCzWKLn3/yZVc8WrH2NLYEFbdcgqxiiU6tVfa5zlwQVE/74CkqRWur8niMcvB7tyO5r7xIOieZnReGqjCnYIIPVXmDd7lRFmWD+Fg+R28eTW8VGdtqZHjJ5xfvnTAI3CWLdAfiEwKfDC22jwhuKoD1wia5GAl2veOy4y5CQrmc1fNWIh9E+jdmnyEdNvj5gtvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Wed, 15 Nov 2023 15:43:26 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 15:43:26 +0000
Date: Wed, 15 Nov 2023 16:43:21 +0100
From: Thierry Reding <treding@nvidia.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <ZVTnGZL4BpsGbt8f@orome.fritz.box>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
 <CALeDE9N=Sd0KzvajD3_hd782hAdKTn30esYcMYv5DoDsrW9+Vw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aYygtICm6r46cTZp"
Content-Disposition: inline
In-Reply-To: <CALeDE9N=Sd0KzvajD3_hd782hAdKTn30esYcMYv5DoDsrW9+Vw@mail.gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 84270ffe-a5d3-4b12-6cd8-08dbe5f19b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47pAHlp3njJqvxuyrHez/lAJa0wUjD/AhO+m1DXdjS6TzNU+QjhSnJMYK3MC2bUxYKTnPr4KzdioVb9qLeLBV+2c03eEMXN/u+cSN4KwzWOzLDu5PJOOTq/nbDl4bGrYP5FQhC0UPrniPIn3Vkl54/gXn+TXTqZeE+MwXnhWVTKnlrhxEt5G3RxmFlkDAfCoPAZHmiZpK860LM4EhYgoAu9wY0Bc6yueL8NfB0bQdrFlFsP6yboCY9VQ1lXCQY4j2sNZpsj6gzkQLj75U4FrEAY1byVxQUxnZTyn62omOG203HM+9ut/RpxpIy8S4FmYG5qTSwzqVW7x4DG7fGmTGGDBHnt0BfD2aMY1hFsVWsjruZa/qIf3fxxNRluWKpG7884Dj08NEoI+DNvPtk+/3QEHAAaFssWliFOnMTzVy97taenN0S3lT1E7jlN+LYW/ANtiKYon8DRFUzFd/WNGwU5A7j8eWgtqyYvTR2T3u3r/qWvu6UJtiSqGBUPLnFprOcxJruG3Nb9UQTBpY1jrxWqtvVzuGeLR6V4Q9XyABAzfDIWxzb4WzknssRB7GY9q/SXf5i6C505ncKVC8dgIzj3Tsnvzcgl0OhfkIHMPwq2+qjLeGStM6rKfBurwCYJw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(66556008)(2906002)(66476007)(86362001)(5660300002)(66946007)(6916009)(316002)(8936002)(8676002)(4326008)(9686003)(6512007)(41300700001)(21480400003)(83380400001)(6666004)(44144004)(6506007)(38100700002)(478600001)(6486002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZ1+yAoB+QKDssl3iSLsIHMbLbug4rpAKCh12hjmS1IONN+AlwjpddbmpdzP?=
 =?us-ascii?Q?Nxtshohmw9zU0AsPezvaGN8+ZSAd5/34cxYa4ZuDl9sHrKso0MA+wuumIDVw?=
 =?us-ascii?Q?mgsyLS3VBVHmieGEFe9r2kUKoQ5j7p1WPacoB5rpemBasGjNQNUa+aFMrkMh?=
 =?us-ascii?Q?QhIAYlNSkR+3g+3aG+0sIoTXlA2WqiXIdGL2v9NTHPUCJmui/4kXIIe7HvjH?=
 =?us-ascii?Q?AXonaFoKYIAGtjzXU7U1tuxeHm4foysk5tbIc/RJ1EmcyhU16i1rpoJI7KuN?=
 =?us-ascii?Q?99qgRZz6Win7oe2g8S5lckBomxF0UupptP+UlHti/zSJnaZEPX+w0AajSm3i?=
 =?us-ascii?Q?1lZbmKDRP661ory4fBc8+tmJJPMdxduT8tLADZhzMMlg+E5t0sHBUkM+fVNr?=
 =?us-ascii?Q?OCd4tgkfdc2m9ExqQOJ+qB+16S+i1hzTBZuRTrNFNjVJ3QyTRqizjA4APjH6?=
 =?us-ascii?Q?UdAPsSpHzB48aqVGnZXWmux02P/Guic/uEwqtqI9kM7xHSF1CL0QQgrvmkZb?=
 =?us-ascii?Q?UJZICLhDYgwUWHiRhamPspUYXsoJyg4HuLdaPU9dB+Y4GqF9PYJmD6gtNkEd?=
 =?us-ascii?Q?DntH+hNBqzA0o0cUMr44ViHUPm0txl1FfwVmVm62d4Peo47v1c3ZZQKtDIjB?=
 =?us-ascii?Q?Vj8AoQEYpXOrnFcHAKLNTi36aP4M3g1qXaTbzhQRD/WaqyOfwc8VRsXFnFKT?=
 =?us-ascii?Q?d3wX8bd9iVu5naCZu76FXPxZwHJSmaZWIO4k9kc7m65yucc30U8sVVda406S?=
 =?us-ascii?Q?/Hyli8fJXbNZGLDljNZsaGF9IwIF4cT3OLNO7u5cFGSozM8hb5fI8l4Hnx/w?=
 =?us-ascii?Q?G1djbrhDNZ1DLKJlKrxWd9hfMZtYRKeibINSjwNK6Wl+L6slZ27iLUuw+hfq?=
 =?us-ascii?Q?yiqgDQAEYUFpeKxZTYsJZIorc12CmwzTC535JcNaLWGGOD/7z+dmKTJM2tCj?=
 =?us-ascii?Q?XFZh1nXHNlagfx5TzDqMlw+XwepWy/GawQ73bqJ6BOzrNEnDbTJ1XooW9rJ5?=
 =?us-ascii?Q?DS4F/BwyI/IQlDXPaRYK24uDqMZ3XlH7x53+SNG/aGATNKE2CZz7reIPDiFi?=
 =?us-ascii?Q?h2kFp9VrTExO3hYx0a4hfci3/HeVYisi/CQNJjMFD9/9tBA107DyEsBLxNnr?=
 =?us-ascii?Q?QdGU0/ZFl2wNnLWR6kWeNcovXaYJyCmOS7CY0I1dbm7lfYk0Ko+ZRlV5f60Z?=
 =?us-ascii?Q?crMFy1ViPQdhJKXwRQ/pgGLuermiUDvXjxhbLclNO7Wvk2CsjxIk8GRiFImn?=
 =?us-ascii?Q?TGc18d2LbE8u54aXICRYNGWNUmG7Vd1H0h3jG6xl7PlThZyYGGOYITzg1tTh?=
 =?us-ascii?Q?KUBW8M1bkN1ZVWJ6SBSfyEwNKsp4xJ20a6KnfnhX6/yiu+e5NXo0kpNO01vU?=
 =?us-ascii?Q?udMLvgBv1KKv+vp2NfWzyOJU5YJ5dgdKE/1OyKHmEk9x0Z00qevr7wRCox7U?=
 =?us-ascii?Q?ZwK+/65dKVLZSTZfhpQYmFwQDATngYM1NwDU6cOMmmIcSdRRTQfV6vwTZgdq?=
 =?us-ascii?Q?xKYr5EjymqyCzATNXlpwqDwDMw3oK4HL3r8nqRVCMfKYWlLmsbmJLgUmqYNy?=
 =?us-ascii?Q?DEAEYqMxAmmv/+to/sZG9FvGmD6WUA3iED2A0AR/lzQWRoWlvw48VL9f3mXS?=
 =?us-ascii?Q?u7jrOvDVeCTMea+7veg5mvGu6eq5a+5SOldb21VRXfIH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84270ffe-a5d3-4b12-6cd8-08dbe5f19b27
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:43:26.1077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeMcwu07qOv9TEWZBJ/+0Aa9LDzmqplc+R8itA0zshIPhpfNKbyWKFO+xoxleJlxhKH4ZvwMXHiQCwYz6W7BoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
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

--aYygtICm6r46cTZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 04:52:22PM +0000, Peter Robinson wrote:
> > > > > > > > Since the proposed PMIC patches have been accepted, I see t=
he need
> > > > > > > > to convert boards which I maintain to use DM drivers instea=
d of board hacks.
> > > > > > > >
> > > > > > > > Svyatoslav Ryhel (5):
> > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > > > >
> > > > > > > Is there a reason why the two above devices don't appear to h=
ave their
> > > > > > > .dts files in the upstream kernel?
> > > > > > >
> > > > > >
> > > > > > Yes, there is a reason. Linux maintainers treat submitters as
> > > > > > existential enemies or as dirt at least. I was trying to work w=
ith
> > > > > > linux but I have no desire to spend any time to upstream endeav=
oru or
> > > > > > lg_x3.
> > > > >
> > > > > The usual policy for acceptance into U-Boot is to have upstream r=
eview
> > > > > in the kernel first.
> > > > >
> > > >
> > > > May you point to a policy which clearly and explicitly states this =
as
> > > > a mandatory condition?
> > >
> > > There have been a number of devices rejected in the past until their
> > > DT are upstream but I'll leave Tom, who I've explicitly added on cc:,
> > > to clarify the exact policy.
> >
> > Well, here is where it's tricky. I brought this up for one of the
> > Broadcom MIPS platforms a week or two back, and Linus Walleij's point
> > (and I'm paraphrasing) is there's not really an upstream for it to go.
> >
> > What we cannot have is device tree bindings[1] that aren't upstream or
> > worse yet conflict with the official bindings.
> >
> > So the general way to resolve that is have device tree file be drop-in
> > from the linux kernel, and what additions we must have be done via
> > -u-boot.dtsi files. And in turn, some SoCs are better about keeping in
> > sync with the kernel than other SoCs are.
> >
> > Now, upstream being actively hostile to dts files, especially for older
> > platforms? That's unfortunate. So long as we aren't violating the rules
> > about bindings, the intention is that we don't have device trees that
> > are either (a) massively out of sync with the kernel[2] or (b) kept
> > intentionally mismatched from the kernel.
>=20
> I don't believe I've seen upstream Tegra maintainers being actively
> hostile towards updates for older devices, I know they have certainly
> defocused them, but I'm not sure that's what I'd consider hostile.

No objections from me on upstreaming older devices in Linux. I used to
be able to test most of the older devices, but many of which I used to
have direct access to are now defunct (for varying reasons). So I will
have to rely on the community for testing etc. since I cannot scale to
the point where I personally have all of these devices.

Now, I don't think that's hostile and if I ever came across as hostile
I'm sorry. The intent was never to reject device support. Obviously the
Linux kernel has high standards and sometimes that can be off-putting,
but I don't think we've ever asked for anything out of the ordinary.

Thierry

--aYygtICm6r46cTZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVU5xcACgkQ3SOs138+
s6HDuxAAig2gdcOrpZiCr+tzKOUVgif/h/b/T0Qw1vrEJ+HXRBXOOeDnW/9uA1NP
yjxNYysLV4NPaGloixxKFtRIhIpeaJFn9OsJeRXPKBNCqqQz+ISopFQB77GYKF+y
1w0ZYKuo9eSodd7FYJsUQmlNlv3U3B0KsqfrD2sSXX6dY8rHznucQGl+qh4GVI5y
Lyh3IoSxYHjOII7HYCnV8N5QK9Njcr23M5vVXZtfyEHcBajom4tewUb3FAm+uEth
JGggWt6wE4YLdwe+PsNEegYsvaJEZg6Tcayqur5/zFehjmuKNdE4cVUzh01O86v8
/0A6y1Jcn5RqLFvslR7o0WOf0nXTdIg5b5lDQ6JUXRxirvxL6Cdg8mVyJVOuTvDm
6auleAG6jdGFKFZN4kt4c9RDl36FT/8dat3CL3wwolINPje2kJB5kcSf5eSw76fg
s8dTQisXzwC0ciLrKeyGUSx8ySkfzjyhj+d2xq4NTwMZQbwN89bu+sR5LYzYUIkL
EoC14/Om5ajQmy8rn0FZ5TpIeH6+wJDAEHxEile7MbK89yxdXuYrjMovEvV8s8dO
qWrne9bple3sIMEZmslJWN9QpkWwVCOpgo2o7S6EdOROrNrv3euxKOGgrNFKhYy0
WTtcMH4DslqGSsmqHnORzXT13tTvpBhw3SzyItEvi9DysICBUCg=
=MWBL
-----END PGP SIGNATURE-----

--aYygtICm6r46cTZp--
