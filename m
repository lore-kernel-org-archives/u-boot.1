Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B60C2BD09
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 01:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D829B883E7;
	Tue, 25 Jun 2024 03:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="Aj4jJ7QP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448E288411; Tue, 25 Jun 2024 01:56:43 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29CA383989
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 01:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1719273400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBMvDXRM+siwtkf+otDfB1XWZoppBtRB71eytBQOM4U=;
 b=Aj4jJ7QPljrkM7tuuwpsZesYo4PwhVesAkJ2M5Z+Ov/pZMkbYiOWqStQdJ2T/XWVxJMNSB
 44ze0PzqtWx4xBOQxs7MdUqbPhvXC0LqJU5FYsRfIEs85KSi4ZIJ/veFk/LbEnY9CN6tp4
 +fnXXjBkqfulMXewjwUuEVUrwij+uOc=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-42-0TYmU0xhOly-sgzUhAGFQQ-1; Tue, 25 Jun 2024 01:56:38 +0200
X-MC-Unique: 0TYmU0xhOly-sgzUhAGFQQ-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR3P278MB1427.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 23:56:37 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 23:56:37 +0000
Date: Tue, 25 Jun 2024 01:56:35 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 25/42] test: Allow connecting to a running board
Message-ID: <ZnoHs6YiQlsoUWrL@toradex.com>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-26-sjg@chromium.org>
In-Reply-To: <20240611200156.2245525-26-sjg@chromium.org>
X-ClientProxiedBy: ZR0P278CA0187.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::9) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR3P278MB1427:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f9c4d2-984a-45df-dd4b-08dc94a948f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z3XQaSL8pGcEKEfYRG6xSRvhDN+zKiXfE2apgT4JncoA/RuAXRMMDMj9PPhb?=
 =?us-ascii?Q?bvz2dGDSmUumy3A30rW1ALVkikA6JS7MtvC6HmSKEa9OmNpL7WYx9lDWKfFZ?=
 =?us-ascii?Q?hdx20tryzYLZpdfKq4NDJWV92J692S2sjqmPRFykPF3A3DBnqxZs8R+flabn?=
 =?us-ascii?Q?fPsXDJNo/X2Je2xNXiZBVl3uriGK8CmDr+Rc0F1A7N/hVaxqw+hIzZHGCGWE?=
 =?us-ascii?Q?hjEiqKumiel3sfgVDOy59q1pHMdXBnktes5NocRX88NnPD8SYSj5Db4Z1QIM?=
 =?us-ascii?Q?mpNeF/j4ICs7D+OLgYU4rNjbNlHd7kLoG8AKVIlZmFEmplwXbKbdYJIM0ale?=
 =?us-ascii?Q?Wx70B2InYx6NR5Q7PWzfKXsinkkt1i+qvZJtGm0dTAEhzV9btQ30op3Debv2?=
 =?us-ascii?Q?9DIRHb7hPWcIa4kNR+qGqfvfDuovPNDvOEon+FCIRbfxvZ9PpQGHC/JaW3KG?=
 =?us-ascii?Q?0/5nacrRLg2473Y2bqtZdVkVXsEh0M3xGkMonMspMLxh0yyC7UMctzGh8esQ?=
 =?us-ascii?Q?u02Zg1MrNuK0aTq+fdLcmpReV7LsG/saLKyIGV0/N9wWQbAC8N0KXKKAZpGv?=
 =?us-ascii?Q?wyMn8t7brWAuaIeH+LWrOPb/jOgGX/s33GNuJczuKwwlPcyuxhjRDNS4Li3M?=
 =?us-ascii?Q?4q4zdUQSNCw1ZvOUGJyiwcvyRx3yraMsM2a8/bQxgUnDZfZoq7HOznt2pBcN?=
 =?us-ascii?Q?vzkRyqIqxSPJd26PbgBkzljE6oahnZfHdJdMdMdOet1ji7Ks7oLoKLri3x30?=
 =?us-ascii?Q?+wqllwFeS4EoxESkj65PfY2nVRq96biVFpBut7QjYsG9Xhiref5yNj1iVCMH?=
 =?us-ascii?Q?QBBE/fhzG4YUWd15Kg43/F4iHfdvMBnM160mR8eRKTQDvV85w2K9eUei9vtc?=
 =?us-ascii?Q?+4iUPJSmJqSulqUNsRZNPxSkdXR6qSN0kBaxwEMhJz2A0jqGIXgOEh7C6oHd?=
 =?us-ascii?Q?6TIyEgOMWGVTzP7stlpnzDrmpXEp0R61215gBNuFh9gqeW5kwzKo1RMP4uHm?=
 =?us-ascii?Q?ZIur842BBVqJzRDifdJAyfo5f9G67XLP9JR4h3B/ujdpSWL/iB8HQ0L6jpkL?=
 =?us-ascii?Q?0lquZC2NRtKTeEMM87GUs3uF/WMmcke1ERrLe+NvwHRRcT9s93MpuNApMlFS?=
 =?us-ascii?Q?FD3tcaJ7wCQw5iWh3I1pnnugkiI/r4YDT3sghfMFyLQft6dNU8YQzMSYE44P?=
 =?us-ascii?Q?rZdipaprFDLJW/RPe1EDc2zXJsrdei/nXPgbO2ut3gmfw7i1dAh8kZhr46pC?=
 =?us-ascii?Q?/lUSg/6uATJ/V0Og3ToI0AUvo3MKuVJgxKVx1H6M4lHcIYv3RuvbRDh+MMwb?=
 =?us-ascii?Q?Yn7hgZcQihbz+e/G2hKr34fG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckFLe9oQqg5VCDljxmoOJwPPjSnU6aReKF9nq6VqOI6ql6TKeN+IOb8Pe7tt?=
 =?us-ascii?Q?Ow+2D3/lg9kPVfBxGMjflWKVjGrdkJW+K5xxt62fFzKZ0TSCdj2unpIynRdr?=
 =?us-ascii?Q?IgGAXiwFQFp/Ng0Z69tLeWfZNeTZNQf2KgnKSAxPsxbC29dSFg04HOgV05eO?=
 =?us-ascii?Q?6I60G/kg2mhJiNf9iokjLgMZg1YvKCjZqDZ3pkczPMoxP2N06J2eNGmJiQFW?=
 =?us-ascii?Q?HxzzuipT8q8gTSJdZ7K+4yU8oFsZFq3KV86tOebkggE73kA3/nYYeA4Y0h+v?=
 =?us-ascii?Q?OAJ2LM91c8J5iRF0KVNQLR4Ob1OVDwWDzAiJaGCuG26cWUoBhxrMnrvsEQsG?=
 =?us-ascii?Q?WjPDxMbApVrslSyPrSy92lOga0SC/Mrcp5ah345FzsuE6vbAwZiDlKCTUrXu?=
 =?us-ascii?Q?5phkNPhRkLze7ZHuMJwQH/CAFOpQgSiA1+EmMijWTcIFPMDVjSihWBhY0Vil?=
 =?us-ascii?Q?WcO1qpIei9mQl8712rjoHqlE83kYviF9pYgqSjHmWGWx6M3gxGR9bO0lhBVp?=
 =?us-ascii?Q?PIdQ9gkoMiegUSdle2Q/syIbEEwTkzp3gH6lkV42OwLSZ9xo8GwLiACVWOE2?=
 =?us-ascii?Q?H09SkiAnF+7VTinW0P2tppGPsMuPNRJD6AJM+spYeroDKI68T7QIdOvIqRgX?=
 =?us-ascii?Q?pWCOEZ9jqx4iJLIQJLtAbGuPzRDG6ARiGtMB4tkU8vA+jwj8ENEyO8wTm9LD?=
 =?us-ascii?Q?s9niQbAe0LZCVKX+ktJdARqnTaodVa+MOqzzDuaXGVClOnIb/w9c48qbAZdN?=
 =?us-ascii?Q?LaB3wbHkjBIf3SCL1ks4QbGZCyCv5w5km3eE5cqiJkOtAcZ8+0PM3l3cwAvT?=
 =?us-ascii?Q?mQiQyDgOZljIz1d6/X/pF2LZ2WQyU4rggYQqRNNn+9H4f8mKU2bYmRN26xfp?=
 =?us-ascii?Q?Mdh045QQhIdYHgS1eR1QfeesmOwctTZnQ6CmOTEKH8THR1l8zwN5a9ArLKLt?=
 =?us-ascii?Q?tK751nINiNGSsfNsHZ0B5oUL+mD1TRP8gX6O4Y2e6crzVhVMI4IYm9hyxPhE?=
 =?us-ascii?Q?f1m9a25dSCWyULfArcNYOfV91Ja8dXmu4TiudbIT6hrvmU/rsDQkcVa1UQ8Z?=
 =?us-ascii?Q?aBM7naMHBNtZ8VA3Kv6APTJtkK3Rzise9bwLMnD141Ma8/xIF2T8x003iUU7?=
 =?us-ascii?Q?vFWuDGRe/EWUnpauf3sXxKAt+y4r2GGiEJXkDKQONBRMvoKxSf6+7/k4P7vk?=
 =?us-ascii?Q?HHuPu+E5jcIcHLWk0hQwt1k+ElcXmVXkpyuMk8pNQMId5N+2AYGorM6Gefce?=
 =?us-ascii?Q?O8UHvsXyEhUvJROvcifXYcSCToZ/9+gPwhMFILlyqGRKjwia866l+RaL2eu6?=
 =?us-ascii?Q?i/ceRiHMDZSFfkQW4fqZH4bV5IUSHLnT0QCO2v0mYGKlE3tlzAd3+zLK1MmL?=
 =?us-ascii?Q?GJT4C15YfxHg6hl1NDdhjEuthxx92cbQ5TgVefDrJceUUyTM3QArnD8bO5/i?=
 =?us-ascii?Q?b4E5iNqZM9dlU3/9+1R/82LCEFAsjkXXkDygL/kOG2rHjQmI3l1udnoLinAN?=
 =?us-ascii?Q?7kSYTmtAbpPt4yqWdF1tvsDwyHNxfzuW9+24SJJWKIf/uSihEnisf1l/EfYo?=
 =?us-ascii?Q?oW68EtxkPs8SH50gFc0xPSpGbzade+y/S1eHDev0p+PWfj2P+PJkEw+0v6h2?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f9c4d2-984a-45df-dd4b-08dc94a948f2
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 23:56:37.5514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLdRsm0Tt+Y1wrHmbDQ7XoZoM3F/hfwN87hseGMFwxuJOL/tz3x4KZ5VcTLl6qzDI6fw7Y/EQQBKQCxVc3GdKMvfqvM9Q+uWg2ZF8Aw/4Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1427
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Jun 2024 03:15:32 +0200
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

On Tue, Jun 11, 2024 at 02:01:39PM -0600, Simon Glass wrote:
> Sometimes we know that the board is already running the right software,
> so provide an option to allow running of tests directly, without first
> resetting the board.
>=20
> This saves time when re-running a test where only the Python code is
> changing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/py/conftest.py                   |  3 +++
>  test/py/u_boot_console_base.py        | 14 ++++++++++----
>  test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
>  3 files changed, 25 insertions(+), 13 deletions(-)
>=20
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index fc9dd3a83f8..ca66b9d9e61 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -79,6 +79,8 @@ def pytest_addoption(parser):
>      parser.addoption('--gdbserver', default=3DNone,
>          help=3D'Run sandbox under gdbserver. The argument is the channel=
 '+
>          'over which gdbserver should communicate, e.g. localhost:1234')
> +    parser.addoption('--no-prompt-wait', default=3DFalse, action=3D'stor=
e_true',
> +        help=3D"Assume that U-Boot is ready and don't wait for a prompt"=
)
> =20
>  def run_build(config, source_dir, build_dir, board_type, log):
>      """run_build: Build U-Boot
> @@ -238,6 +240,7 @@ def pytest_configure(config):
>      ubconfig.board_type =3D board_type
>      ubconfig.board_identity =3D board_identity
>      ubconfig.gdbserver =3D gdbserver
> +    ubconfig.no_prompt_wait =3D config.getoption('no_prompt_wait')
>      ubconfig.dtb =3D build_dir + '/arch/sandbox/dts/test.dtb'
> =20
>      env_vars =3D (
> diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base=
.py
> index e4f86f6af5b..a61eec31148 100644
> --- a/test/py/u_boot_console_base.py
> +++ b/test/py/u_boot_console_base.py
> @@ -413,11 +413,17 @@ class ConsoleBase(object):
>              if not self.config.gdbserver:
>                  self.p.timeout =3D TIMEOUT_MS
>              self.p.logfile_read =3D self.logstream
> -            if expect_reset:
> -                loop_num =3D 2
> +            if self.config.no_prompt_wait:
> +                # Send an empty command to set up the 'expect' logic. Th=
is has
> +                # the side effect of ensuring that there was no partial =
command
> +                # line entered
> +                self.run_command(' ')
>              else:
> -                loop_num =3D 1
> -            self.wait_for_boot_prompt(loop_num =3D loop_num)
> +                if expect_reset:
> +                    loop_num =3D 2
> +                else:
> +                    loop_num =3D 1
> +                self.wait_for_boot_prompt(loop_num =3D loop_num)

Hi Simon,

I had a very bad day, so here you go:

=3D=3D ?

/Andrejs

>              self.at_prompt =3D True
>              self.at_prompt_logevt =3D self.logstream.logfile.cur_evt
>          except Exception as ex:
> diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_conso=
le_exec_attach.py
> index 5f4916b7da2..42fc15197b9 100644
> --- a/test/py/u_boot_console_exec_attach.py
> +++ b/test/py/u_boot_console_exec_attach.py
> @@ -59,15 +59,18 @@ class ConsoleExecAttach(ConsoleBase):
>          args =3D [self.config.board_type, self.config.board_identity]
>          s =3D Spawn(['u-boot-test-console'] + args)
> =20
> -        try:
> -            self.log.action('Resetting board')
> -            cmd =3D ['u-boot-test-reset'] + args
> -            runner =3D self.log.get_runner(cmd[0], sys.stdout)
> -            runner.run(cmd)
> -            runner.close()
> -        except:
> -            s.close()
> -            raise
> +        if self.config.no_prompt_wait:
> +            self.log.action('Connecting to board without reset')
> +        else:
> +            try:
> +                self.log.action('Resetting board')
> +                cmd =3D ['u-boot-test-reset'] + args
> +                runner =3D self.log.get_runner(cmd[0], sys.stdout)
> +                runner.run(cmd)
> +                runner.close()
> +            except:
> +                s.close()
> +                raise
> =20
>          return s
> =20
> --=20
> 2.34.1
>=20

