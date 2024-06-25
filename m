Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8C2C2BBCA
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 01:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBAB884DD;
	Wed, 26 Jun 2024 03:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="fCCY3UH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268F5884A9; Tue, 25 Jun 2024 17:21:24 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27CC488452
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 17:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1719328881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQCAej/KhGBpw+QnaHsxS/tDG1311cyyIHd2cmSrinw=;
 b=fCCY3UH8luDnZzRyJeRA1Mf/MVTlS72pYtz2y8RK0j4W3fqbJl2LtsvmfvhhJQKpKDEKVt
 FYw5/PvebkB9kcvPBc51vKMnMa9p46Mv+pKLhoAzWX8EKwDHQd3gMjM9cuCXvhMFNy0HlA
 o0By/rqDoHpilViJTSIaalmPHptACfE=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-n1cXMw1eMBGTOtJqViYuDg-1; Tue, 25 Jun 2024 17:21:17 +0200
X-MC-Unique: n1cXMw1eMBGTOtJqViYuDg-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR1P278MB0998.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:21:15 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:21:15 +0000
Date: Tue, 25 Jun 2024 17:21:13 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 25/42] test: Allow connecting to a running board
Message-ID: <ZnrgaZaXQy+xCUM6@toradex.com>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-26-sjg@chromium.org>
 <ZnoHs6YiQlsoUWrL@toradex.com>
 <CAFLszTiR6oabXzbrjC4DTvJM11HfSyMZSergdA1=isWY1pVeOQ@mail.gmail.com>
 <20240625141417.GN38804@bill-the-cat>
In-Reply-To: <20240625141417.GN38804@bill-the-cat>
X-ClientProxiedBy: ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::14) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR1P278MB0998:EE_
X-MS-Office365-Filtering-Correlation-Id: a982b6d7-c023-48d6-8503-08dc952a7464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XWPoRNzYQNS0fByy+fJAlUF5yCPGd/QERth85tb8ku5OpptOHJ48ZU1JMc6u?=
 =?us-ascii?Q?DltU3mPRMTZmoCVoab+rlS5txlM85RcDMSUaAd9TqC6eMGjBj1JfRLv+nDBv?=
 =?us-ascii?Q?YrLmk549MP13lzXaV7Owyb3KNcN9qcjVtQ5cJgjE1Vhx/qW4h1wJwxsgLhGM?=
 =?us-ascii?Q?w12/kjqooBquxcU/DxjKbiyNt1/fzVHUT6EjrAHNnrVrm8Tzg7N8DXIfYYK9?=
 =?us-ascii?Q?Xtr8yzfio/jAMsf8L2yQOsuxvCdE7HzNWBJFhUYiP1D/zxdFIkVwFQMa3aUh?=
 =?us-ascii?Q?AOTXVaTrjaefzPLS5A/q2U/8nF8aAQlOi7ltjMQnEC84P+zFq14y3zkJpFF7?=
 =?us-ascii?Q?5gxjxDlmLrdP8w7HlRNcusP8JOhbGd96iMeNw2IsFjLUUt0w1Oag50Cnh2Sp?=
 =?us-ascii?Q?Z0UWmI1kHosF5vpy5Y+uZp4WoiiG/oXsAF+Mkgcfaf3cqZGC/McBPZVg0Aga?=
 =?us-ascii?Q?L9ol34C8bbVLHY0yRooQBpNGlOHKPHAyxP3gRYeEw283xnjBRVeh6qQuf64m?=
 =?us-ascii?Q?gxk38FgVNXOgcZFoAvk6UkeXMb5KYqyFQolZkOw9me1lNFanrEiZk/+jZadm?=
 =?us-ascii?Q?PJnsTk3a/wuPrU0Oo+j7HVUql3O4KlGOTqEsCETPiY/0yJPhrfGgsVBurTPR?=
 =?us-ascii?Q?WeC9zuDuSH3Vgvu6/G1BYgeCw3x8K03xclZ8feQb8AMHqCvjmkG4ftRINr/f?=
 =?us-ascii?Q?tvr50oaFtAprTXxiQiWjl0iU3CGUhgYakHLf8QzTix7yfrxN610Cf4nyjnEw?=
 =?us-ascii?Q?polxW1LZpfPfZECq+gAHZ3sG8DM/lkFCZ49kUF+iIWM1YmW+WdlhlxmexBOK?=
 =?us-ascii?Q?bU1p5y2H3o6ECuk3fmfx0ORii/snpwGz2jSzPIGCdHaALLJgnog1U+fIEmiL?=
 =?us-ascii?Q?2ZZ+xOzkWi9U20BkIf2VLkS4Slrj5xxGgwdNHQLw79/THBC0uKHMNynG8qup?=
 =?us-ascii?Q?fpAoJAygTykvvbdXRMNe3YMAPtBoYvhbwUyDeqXc1p/A34zaBFl+1KnKWOSm?=
 =?us-ascii?Q?IyZxh+5wCP+PfJQ68L1UMhBoEmPCEg05ndW2ijHY2y84hSCvrwW4IzmgO5pV?=
 =?us-ascii?Q?1NOvCXNJ4Y6LF6P8GSAXnNFCRmeTM6ma/jQTKc2xFnvDMzQbGpUsh+y15Wes?=
 =?us-ascii?Q?sdLTga20sXrj71fd7uvl3326x0O6QGid+LFCKX0tvJBUkvlLBr2UIeD9BI1z?=
 =?us-ascii?Q?si/nzneChAXlReFstG27sDyjtPZdBgRnb1ToqZgCN1ZCSgB3DBcmqj5evJ2G?=
 =?us-ascii?Q?PGE/e9htQ+2/wP5///nyNGumD9F+h418KkTzOlp1Jt/QbBCKw8PzcIjkwD1N?=
 =?us-ascii?Q?0o5yxXzU+wUCLJxBQcJ7eA37?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGtQXoJj1lqjOQPKbCSVH16m3VcNU1rKX3d1ftpCg+PtKIdjb97FMK3naO0F?=
 =?us-ascii?Q?wuRdwT6A+S6gJAB+8JsBjJFyrQXYUBFTbdEqikOnfXndWtLKL+KQ9fiMCy/5?=
 =?us-ascii?Q?lLaJOq54TM2OjJkJ2lLTxbnvBLxiLMMtWD5gHpwsH7YZx4Q1H6fOAbljzTG4?=
 =?us-ascii?Q?NGdWRhzqXI+FVA7uY5WPYaXLpb0LTj+UTPSsAXsVuwsxn5zZ6MpEPB1cUaj9?=
 =?us-ascii?Q?Qq+Ri1jG2JWc35QtzTu0p9fopSIPrUPzrwajRsSzALxKQMZyFqvJ6/Fdg9SP?=
 =?us-ascii?Q?3kiQxmxe3FTOq1rQA/1bbX+PhTFgHPTP28wD84hlMcz/MVB/arvgIw1KRNDR?=
 =?us-ascii?Q?AX3IXxnPQigpykK7XOJPuHcXO2tCZVpbJvMC+PaDAtAOeMJiSSWFWh1VqWxo?=
 =?us-ascii?Q?67QvE98B66NstSV4oG8IPZpLUS0qfZpYKiZ7XVZMc/tOqopUG9x3wNoihC1E?=
 =?us-ascii?Q?hmCN9s59/tbJ692NYt225xlky9lmt864RlFaz/nmuZp9oRpYkfrdyPEOiCv6?=
 =?us-ascii?Q?EitOMIEkEUCA6xPdF1pfCRcMEL2midF5wnmYgAut3h04y776V05vF5KUEB7j?=
 =?us-ascii?Q?n/6Cs2scICZaDA1JNRxUuLMmxEgDEI1cWgOTyiIe/BAAh4lgnLTXXnLQ2REo?=
 =?us-ascii?Q?sDNi9PeAGFZ/mFV4onqKRFsSuwdiOJeW6OODEk4M1aoha+3hQ+hEfv8Yn+jZ?=
 =?us-ascii?Q?SYKY+H+bGfZ1uksPPn8SVg/GULTbV+j7ybVfyVoxTITZX7NgvA1rZDUf79oV?=
 =?us-ascii?Q?j2jMF0OaNXZmjvik30t7rcQvgJh96+4TEkysO5nMmEca2lwQzrbzemZp8erk?=
 =?us-ascii?Q?lfKBqtk+aIah4n9+cxgs3d4dyOolFLdRWK/ULeFb7wzhV9b4jVjGRyaU+VZ1?=
 =?us-ascii?Q?weBMRlQr4FE7L7psvvfrSs4jrA8vbFRCzyeySv0M1mjH3U7xZ/hMYie2+x9k?=
 =?us-ascii?Q?RQMYkm9bh9n/t7H8wI60dQE/EH0SVIFdbqz0m7Xpcn/r7DOo7+ZZ8+0+LEOk?=
 =?us-ascii?Q?1Z2Cc5nOsPQS2IQ88sGnHXpoPKnYJzUkYXBGVWDb7kwZ/GcUM3ZzAIWpbrOI?=
 =?us-ascii?Q?3jgjiqIPmYxurjrJbbFQaDetwYUYS4SnNmOxIVcC3sAJ+8V7ZlMlL5yei1uQ?=
 =?us-ascii?Q?Ixx69Pzv4WaKnnimfxHKBuyoppzMWhwSi4C578dQwzYgFyG6zkr0kyNNuHLc?=
 =?us-ascii?Q?NhdHJvuCrPhm1mLb1aRjX97AG9cgja8XZ9/p68la2Se6Ces5qKZGfeuCcX3Z?=
 =?us-ascii?Q?pidbfkb77+CB/Cc+Ia3K3tzu8tilRcQlQTh8go7YkAYAh90h6Pak2pZPIjVl?=
 =?us-ascii?Q?B/ISpb6K1t4YrU5BnZFAPujY895iiOy4A2SK4PoBLvTUlwsCL9jFk2lrj7OZ?=
 =?us-ascii?Q?QTH8iwe2UyuB0nEtSJ02jYsU8wL35r+kaERZWCVoTK2eI9nh6hWT2yCA6mTX?=
 =?us-ascii?Q?GOAzfku/FYS0Ji6TLUgp3vO0m/8P0czlFmcUmlUKucknJIe6M6rrfKW5XGA9?=
 =?us-ascii?Q?oXbvuNeKMk6UYdYPFAb4iTxaoXLi96yyiNC8AvbnP1/EdCuqf2055n0l9fUO?=
 =?us-ascii?Q?TOSlOlqB89QV8XiWz8dK57/6629MMYNaguAn8WSQgoMw0d3/mfuoTifngg38?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a982b6d7-c023-48d6-8503-08dc952a7464
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:21:15.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AX7IPj90nSWPZYqwweBtCz89+4NKK5+Lo6bR3xCYNza3trYqGsSdCOQUqsfUzfOkiTXm4kZdPcH3gZk54Us2ZnRajsuSgZXjWvr6rwVgDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB0998
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 26 Jun 2024 03:59:08 +0200
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

On Tue, Jun 25, 2024 at 08:14:17AM -0600, Tom Rini wrote:
> On Tue, Jun 25, 2024 at 01:31:19PM +0100, Simon Glass wrote:
> > Hi Andrejs,
> >=20
> > On Tue, 25 Jun 2024 at 00:56, Andrejs Cainikovs
> > <andrejs.cainikovs@toradex.com> wrote:
> > >
> > > On Tue, Jun 11, 2024 at 02:01:39PM -0600, Simon Glass wrote:
> > > > Sometimes we know that the board is already running the right softw=
are,
> > > > so provide an option to allow running of tests directly, without fi=
rst
> > > > resetting the board.
> > > >
> > > > This saves time when re-running a test where only the Python code i=
s
> > > > changing.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  test/py/conftest.py                   |  3 +++
> > > >  test/py/u_boot_console_base.py        | 14 ++++++++++----
> > > >  test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
> > > >  3 files changed, 25 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > index fc9dd3a83f8..ca66b9d9e61 100644
> > > > --- a/test/py/conftest.py
> > > > +++ b/test/py/conftest.py
> > > > @@ -79,6 +79,8 @@ def pytest_addoption(parser):
> > > >      parser.addoption('--gdbserver', default=3DNone,
> > > >          help=3D'Run sandbox under gdbserver. The argument is the c=
hannel '+
> > > >          'over which gdbserver should communicate, e.g. localhost:1=
234')
> > > > +    parser.addoption('--no-prompt-wait', default=3DFalse, action=
=3D'store_true',
> > > > +        help=3D"Assume that U-Boot is ready and don't wait for a p=
rompt")
> > > >
> > > >  def run_build(config, source_dir, build_dir, board_type, log):
> > > >      """run_build: Build U-Boot
> > > > @@ -238,6 +240,7 @@ def pytest_configure(config):
> > > >      ubconfig.board_type =3D board_type
> > > >      ubconfig.board_identity =3D board_identity
> > > >      ubconfig.gdbserver =3D gdbserver
> > > > +    ubconfig.no_prompt_wait =3D config.getoption('no_prompt_wait')
> > > >      ubconfig.dtb =3D build_dir + '/arch/sandbox/dts/test.dtb'
> > > >
> > > >      env_vars =3D (
> > > > diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_consol=
e_base.py
> > > > index e4f86f6af5b..a61eec31148 100644
> > > > --- a/test/py/u_boot_console_base.py
> > > > +++ b/test/py/u_boot_console_base.py
> > > > @@ -413,11 +413,17 @@ class ConsoleBase(object):
> > > >              if not self.config.gdbserver:
> > > >                  self.p.timeout =3D TIMEOUT_MS
> > > >              self.p.logfile_read =3D self.logstream
> > > > -            if expect_reset:
> > > > -                loop_num =3D 2
> > > > +            if self.config.no_prompt_wait:
> > > > +                # Send an empty command to set up the 'expect' log=
ic. This has
> > > > +                # the side effect of ensuring that there was no pa=
rtial command
> > > > +                # line entered
> > > > +                self.run_command(' ')
> > > >              else:
> > > > -                loop_num =3D 1
> > > > -            self.wait_for_boot_prompt(loop_num =3D loop_num)
> > > > +                if expect_reset:
> > > > +                    loop_num =3D 2
> > > > +                else:
> > > > +                    loop_num =3D 1
> > > > +                self.wait_for_boot_prompt(loop_num =3D loop_num)
> > >
> > > Hi Simon,
> > >
> > > I had a very bad day, so here you go:
> > >
> > > =3D=3D ?
> >=20
> > What does this mean? I hope you have a good day today.
>=20
> I _think_ this one is that "self.wait_for_boot_prompt(loop_num =3D
> loop_num)" should be "self.wait_for_boot_prompt(loop_num =3D=3D loop_num)=
" ?
>=20
> --=20
> Tom

Yes, that was what I was thinking, but now after another look I see my
comment is wrong. Please disregard, again.

