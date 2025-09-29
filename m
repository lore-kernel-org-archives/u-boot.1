Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D88ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 17:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101E28319C;
	Mon, 29 Sep 2025 19:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gK/4ZfnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F4D8329F; Mon, 29 Sep 2025 19:25:10 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9D382A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 19:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 63EF7C0244E;
 Mon, 29 Sep 2025 17:24:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0B99606AE;
 Mon, 29 Sep 2025 17:25:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A14F8102F07A4; 
 Mon, 29 Sep 2025 19:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759166702; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Al0anWoLFpP7nr75QVVdsWOD3ZeSvYssbKIh1ud0hEY=;
 b=gK/4ZfnX4mnDUwzdcNQQkBmnnrY6P5AMzWkQZfMfRuWjsXwe/9saeE0MwP2TYWZoYbQGcl
 R24VNxiy1CEjueLqobp6ElD8uVUmlB2ZL8YGlwbWuebQNY2NC/cmhkuZ+mDzjRa2bU41WG
 8Nbn2Qqh12eAkzo7HbxKY2YAG73SRUSD/mJmMp/l0+M41QNl9TLwwSpRZjQHAWTvzV6dgq
 XAAUk+Of6EIZU8Te/+EgTeK1pDLhIOGZJAut4Zn/ASpg9G7jw4mQJEGP5DN0ALJWWJHS2r
 R0NhYuL1zTWjAE5RpXDI+KoDxGcR2wp7gWFyUNasoc7I0ty38quX17MAjSv+rA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Hendrik Donner <hd@os-cillation.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] scripts/checkpatch.pl: Resync with v6.17
Date: Mon, 29 Sep 2025 19:24:32 +0200
Message-ID: <20250929172434.1034898-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This resyncs us with the version found in v6.17 of the Linux kernel with
the following exceptions:
- Keep our u-boot specific tests / code area.
- Keep the location of our checkpatch.rst
- Change the "use strscpy" test as we don't have that to strlcpy
- Keep debug/printf in the list for $logFunctions
- Keep checks to "env" files

This also syncs the spdxcheck.py tool and all the associated
documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 doc/develop/checkpatch.rst |  54 ++--
 scripts/checkpatch.pl      | 525 +++++++++++++++++++++++++++++--------
 scripts/spdxcheck.py       | 186 ++++++++++++-
 3 files changed, 616 insertions(+), 149 deletions(-)

diff --git a/doc/develop/checkpatch.rst b/doc/develop/checkpatch.rst
index b52452bc296..d5c47e56032 100644
--- a/doc/develop/checkpatch.rst
+++ b/doc/develop/checkpatch.rst
@@ -168,7 +168,7 @@ Available options:
 
  - --fix
 
-   This is an EXPERIMENTAL feature.  If correctable errors exists, a file
+   This is an EXPERIMENTAL feature.  If correctable errors exist, a file
    <inputfile>.EXPERIMENTAL-checkpatch-fixes is created which has the
    automatically fixable errors corrected.
 
@@ -181,7 +181,7 @@ Available options:
 
  - --ignore-perl-version
 
-   Override checking of perl version.  Runtime errors maybe encountered after
+   Override checking of perl version.  Runtime errors may be encountered after
    enabling this flag if the perl version does not meet the minimum specified.
 
  - --codespell
@@ -342,24 +342,6 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/RCU/whatisRCU.html#full-list-of-rcu-apis
 
-  **DEPRECATED_VARIABLE**
-    EXTRA_{A,C,CPP,LD}FLAGS are deprecated and should be replaced by the new
-    flags added via commit f77bf01425b1 ("kbuild: introduce ccflags-y,
-    asflags-y and ldflags-y").
-
-    The following conversion scheme maybe used::
-
-      EXTRA_AFLAGS    ->  asflags-y
-      EXTRA_CFLAGS    ->  ccflags-y
-      EXTRA_CPPFLAGS  ->  cppflags-y
-      EXTRA_LDFLAGS   ->  ldflags-y
-
-    See:
-
-      1. https://lore.kernel.org/lkml/20070930191054.GA15876@uranus.ravnborg.org/
-      2. https://lore.kernel.org/lkml/1313384834-24433-12-git-send-email-lacombar@gmail.com/
-      3. https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#compilation-flags
-
   **DEVICE_ATTR_FUNCTIONS**
     The function names used in DEVICE_ATTR is unusual.
     Typically, the store and show functions are used with <attr>_store and
@@ -470,8 +452,6 @@ API usage
     usleep_range() should be preferred over udelay(). The proper way of
     using usleep_range() is mentioned in the kernel docs.
 
-    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms
-
 
 Comments
 --------
@@ -515,6 +495,15 @@ Comments
 
     See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
 
+  **UNCOMMENTED_RGMII_MODE**
+    Historically, the RGMII PHY modes specified in Device Trees have been
+    used inconsistently, often referring to the usage of delays on the PHY
+    side rather than describing the board.
+
+    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the clock
+    signal to be delayed on the PCB; this unusual configuration should be
+    described in a comment. If they are not (meaning that the delay is realized
+    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
 
 Commit message
 --------------
@@ -612,6 +601,13 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **BAD_FIXES_TAG**
+    The Fixes: tag is malformed or does not follow the community conventions.
+    This can occur if the tag have been split into multiple lines (e.g., when
+    pasted in an email program with word wrapping enabled).
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
 
 Comparison style
 ----------------
@@ -899,6 +895,20 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/1399671106.2912.21.camel@joe-AO725/
 
+  **MACRO_ARG_UNUSED**
+    If function-like macros do not utilize a parameter, it might result
+    in a build warning. We advocate for utilizing static inline functions
+    to replace such macros.
+    For example, for a macro such as the one below::
+
+      #define test(a) do { } while (0)
+
+    there would be a warning like below::
+
+      WARNING: Argument 'a' is not used in function-like macro.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
+
   **SINGLE_STATEMENT_DO_WHILE_MACRO**
     For the multi-statement macros, it is necessary to use the do-while
     loop to avoid unpredictable code paths. The do-while loop helps to
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 763287e02b1..6992686f688 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -28,6 +28,7 @@ my %verbose_messages = ();
 my %verbose_emitted = ();
 my $tree = 1;
 my $chk_signoff = 1;
+my $chk_fixes_tag = 1;
 my $chk_patch = 1;
 my $tst_only;
 my $emacs = 0;
@@ -75,6 +76,8 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
+my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
+
 sub help {
 	my ($exitcode) = @_;
 
@@ -87,6 +90,7 @@ Options:
   -v, --verbose              verbose mode
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
+  --no-fixes-tag             do not check for 'Fixes:' tag
   --patch                    treat FILE as patchfile (default)
   --emacs                    emacs compile window format
   --terse                    one line per report
@@ -110,7 +114,8 @@ Options:
   --max-line-length=n        set the maximum line length, (default $max_line_length)
                              if exceeded, warn on patches
                              requires --strict for use with --file
-  --min-conf-desc-length=n   set the min description length, if shorter, warn
+  --min-conf-desc-length=n   set the minimum description length for config symbols
+                             in lines, if shorter, warn (default $min_conf_desc_length)
   --tab-size=n               set the number of spaces for tab (default $tabsize)
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
@@ -148,6 +153,24 @@ EOM
 	exit($exitcode);
 }
 
+my $DO_WHILE_0_ADVICE = q{
+   do {} while (0) advice is over-stated in a few situations:
+
+   The more obvious case is macros, like MODULE_PARM_DESC, invoked at
+   file-scope, where C disallows code (it must be in functions).  See
+   $exceptions if you have one to add by name.
+
+   More troublesome is declarative macros used at top of new scope,
+   like DECLARE_PER_CPU.  These might just compile with a do-while-0
+   wrapper, but would be incorrect.  Most of these are handled by
+   detecting struct,union,etc declaration primitives in $exceptions.
+
+   Theres also macros called inside an if (block), which "return" an
+   expression.  These cannot do-while, and need a ({}) wrapper.
+
+   Enjoy this qualification while we work to improve our heuristics.
+};
+
 sub uniq {
 	my %seen;
 	return grep { !$seen{$_}++ } @_;
@@ -295,6 +318,7 @@ GetOptions(
 	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
+	'fixes-tag!'	=> \$chk_fixes_tag,
 	'patch!'	=> \$chk_patch,
 	'emacs!'	=> \$emacs,
 	'terse!'	=> \$terse,
@@ -337,7 +361,7 @@ if ($user_codespellfile) {
 } elsif (!(-f $codespellfile)) {
 	# If /usr/share/codespell/dictionary.txt is not present, try to find it
 	# under codespell's install directory: <codespell_root>/data/dictionary.txt
-	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
+	if (($codespell || $help) && which("python3") ne "") {
 		my $python_codespell_dict = << "EOF";
 
 import os.path as op
@@ -347,7 +371,7 @@ codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
 print(codespell_file, end='')
 EOF
 
-		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
+		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
 		$codespellfile = $codespell_dict if (-f $codespell_dict);
 	}
 }
@@ -513,6 +537,7 @@ our $Attribute	= qr{
 			__ro_after_init|
 			__kprobes|
 			$InitAttribute|
+			__aligned\s*\(.*\)|
 			____cacheline_aligned|
 			____cacheline_aligned_in_smp|
 			____cacheline_internodealigned_in_smp|
@@ -579,10 +604,14 @@ our $typeKernelTypedefs = qr{(?x:
 	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
 	atomic_t
 )};
+our $typeStdioTypedefs = qr{(?x:
+	FILE
+)};
 our $typeTypedefs = qr{(?x:
 	$typeC99Typedefs\b|
 	$typeOtherOSTypedefs\b|
-	$typeKernelTypedefs\b
+	$typeKernelTypedefs\b|
+	$typeStdioTypedefs\b
 )};
 
 our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
@@ -621,6 +650,22 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+our @link_tags = qw(Link Closes);
+
+#Create a search and print patterns for all these strings to be used directly below
+our $link_tags_search = "";
+our $link_tags_print = "";
+foreach my $entry (@link_tags) {
+	if ($link_tags_search ne "") {
+		$link_tags_search .= '|';
+		$link_tags_print .= ' or ';
+	}
+	$entry .= ':';
+	$link_tags_search .= $entry;
+	$link_tags_print .= "'$entry'";
+}
+$link_tags_search = "(?:${link_tags_search})";
+
 our $tracing_logging_tags = qr{(?xi:
 	[=-]*> |
 	<[=-]* |
@@ -645,6 +690,9 @@ our $tracing_logging_tags = qr{(?xi:
 	[\.\!:\s]*
 )};
 
+# Device ID types like found in include/linux/mod_devicetable.h.
+our $dev_id_types = qr{\b[a-z]\w*_device_id\b};
+
 sub edit_distance_min {
 	my (@arr) = @_;
 	my $len = scalar @arr;
@@ -703,6 +751,17 @@ sub find_standard_signature {
 	return "";
 }
 
+our $obsolete_archives = qr{(?xi:
+	\Qfreedesktop.org/archives/dri-devel\E |
+	\Qlists.infradead.org\E |
+	\Qlkml.org\E |
+	\Qmail-archive.com\E |
+	\Qmailman.alsa-project.org/pipermail\E |
+	\Qmarc.info\E |
+	\Qozlabs.org/pipermail\E |
+	\Qspinics.net\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -802,16 +861,10 @@ foreach my $entry (@mode_permission_funcs) {
 $mode_perms_search = "(?:${mode_perms_search})";
 
 our %deprecated_apis = (
-	"synchronize_rcu_bh"			=> "synchronize_rcu",
-	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_bh"				=> "call_rcu",
-	"rcu_barrier_bh"			=> "rcu_barrier",
-	"synchronize_sched"			=> "synchronize_rcu",
-	"synchronize_sched_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_sched"			=> "call_rcu",
-	"rcu_barrier_sched"			=> "rcu_barrier",
-	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
-	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
+	"kmap"					=> "kmap_local_page",
+	"kunmap"				=> "kunmap_local",
+	"kmap_atomic"				=> "kmap_local_page",
+	"kunmap_atomic"				=> "kunmap_local",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
@@ -1047,7 +1100,8 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
-	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
+	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
+	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
 )};
 
 our %allow_repeated_words = (
@@ -1223,6 +1277,7 @@ sub git_commit_info {
 }
 
 $chk_signoff = 0 if ($file);
+$chk_fixes_tag = 0 if ($file);
 
 my @rawlines = ();
 my @lines = ();
@@ -2725,6 +2780,9 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $fixes_tag = 0;
+	my $is_revert = 0;
+	my $needs_fixes_tag = "";
 	my $author = '';
 	my $authorsignoff = 0;
 	my $author_sob = '';
@@ -2957,7 +3015,7 @@ sub process {
 
 			if ($realfile =~ m@^include/asm/@) {
 				ERROR("MODIFIED_INCLUDE_ASM",
-				      "do not modify files in include/asm, change architecture specific files in include/asm-<architecture>\n" . "$here$rawline\n");
+				      "do not modify files in include/asm, change architecture specific files in arch/<architecture>/include/asm\n" . "$here$rawline\n");
 			}
 			$found_file = 1;
 		}
@@ -3252,17 +3310,79 @@ sub process {
 			if ($sign_off =~ /^co-developed-by:$/i) {
 				if ($email eq $author) {
 					WARN("BAD_SIGN_OFF",
-					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
+					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . $herecurr);
 				}
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
-				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr);
+				} elsif ($rawlines[$linenr] !~ /^signed-off-by:\s*(.*)/i) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr . $rawlines[$linenr] . "\n");
 				} elsif ($1 ne $email) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr] . "\n");
+				}
+			}
+
+# check if Reported-by: is followed by a Closes: tag
+			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
+				if (!defined $lines[$linenr]) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+				}
+			}
+		}
+
+# These indicate a bug fix
+		if (!$in_header_lines && !$is_patch &&
+			$line =~ /^This reverts commit/) {
+			$is_revert = 1;
+		}
+
+		if (!$in_header_lines && !$is_patch &&
+		    $line =~ /((?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller))/) {
+			$needs_fixes_tag = $1;
+		}
+
+# Check Fixes: styles is correct
+		if (!$in_header_lines &&
+		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})(?:\s*($balanced_parens))?/i) {
+			my $tag = $1;
+			my $orig_commit = $2;
+			my $title;
+			my $title_has_quotes = 0;
+			$fixes_tag = 1;
+			if (defined $3) {
+				# Always strip leading/trailing parens then double quotes if existing
+				$title = substr($3, 1, -1);
+				if ($title =~ /^".*"$/) {
+					$title = substr($title, 1, -1);
+					$title_has_quotes = 1;
+				}
+			} else {
+				$title = "commit title"
+			}
+
+
+			my $tag_case = not ($tag eq "Fixes:");
+			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
+
+			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
+			my $id_case = not ($orig_commit !~ /[A-F]/);
+
+			my $id = "0123456789ab";
+			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
+							     $title);
+
+			if (defined($cid) && ($ctitle ne $title || $tag_case || $tag_space || $id_length || $id_case || !$title_has_quotes)) {
+				my $fixed = "Fixes: $cid (\"$ctitle\")";
+				if (WARN("BAD_FIXES_TAG",
+				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] = $fixed;
 				}
 			}
 		}
@@ -3300,13 +3420,13 @@ sub process {
 		    length($line) > 75 &&
 		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
 					# file delta changes
-		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
+		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
-		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
-					# A Fixes: or Link: line or signature tag line
+		      $line =~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
+					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
 			$commit_log_long_line = 1;
 		}
 
@@ -3316,6 +3436,29 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for odd tags before a URI/URL
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+:)\s*http/ && $1 !~ /^$link_tags_search$/) {
+			if ($1 =~ /^v(?:ersion)?\d+/i) {
+				WARN("COMMIT_LOG_VERSIONING",
+				     "Patch version information should be after the --- line\n" . $herecurr);
+			} else {
+				WARN("COMMIT_LOG_USE_LINK",
+				     "Unknown link reference '$1', use $link_tags_print instead\n" . $herecurr);
+			}
+		}
+
+# Check for misuse of the link tags
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
+			my $tag = $1;
+			my $value = $2;
+			if ($tag =~ /^$link_tags_search$/ && $value !~ m{^https?://}) {
+				WARN("COMMIT_LOG_WRONG_LINK",
+				     "'$tag' should be followed by a public http(s) link\n" . $herecurr);
+			}
+		}
+
 # Check for lines starting with a #
 		if ($in_commit_log && $line =~ /^#/) {
 			if (WARN("COMMIT_COMMENT_SYMBOL",
@@ -3401,6 +3544,12 @@ sub process {
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
+# Check for mailing list archives other than lore.kernel.org
+		if ($rawline =~ m{http.*\b$obsolete_archives}) {
+			WARN("PREFER_LORE_ARCHIVE",
+			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
@@ -3482,9 +3631,10 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
+			my $rawline_utf8 = decode("utf8", $rawline);
+			while ($rawline_utf8 =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
 				my $typo = $1;
-				my $blank = copy_spacing($rawline);
+				my $blank = copy_spacing($rawline_utf8);
 				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
 				my $hereptr = "$hereline$ptr\n";
 				my $typo_fix = $spelling_fix{lc($typo)};
@@ -3607,47 +3757,47 @@ sub process {
 		    # Kconfig supports named choices), so use a word boundary
 		    # (\b) rather than a whitespace character (\s)
 		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
-			my $length = 0;
-			my $cnt = $realcnt;
-			my $ln = $linenr + 1;
-			my $f;
-			my $is_start = 0;
-			my $is_end = 0;
-			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
-				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
+			my $ln = $linenr;
+			my $needs_help = 0;
+			my $has_help = 0;
+			my $help_length = 0;
+			while (defined $lines[$ln]) {
+				my $f = $lines[$ln++];
 
 				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
+				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
-					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+					$needs_help = 1;
+					next;
+				}
+				if ($f =~ /^\+\s*help\s*$/) {
+					$has_help = 1;
+					next;
 				}
 
-				$f =~ s/^.//;
-				$f =~ s/#.*//;
-				$f =~ s/^\s+//;
-				next if ($f =~ /^$/);
+				$f =~ s/^.//;	# strip patch context [+ ]
+				$f =~ s/#.*//;	# strip # directives
+				$f =~ s/^\s+//;	# strip leading blanks
+				next if ($f =~ /^$/);	# skip blank lines
 
+				# At the end of this Kconfig block:
 				# This only checks context lines in the patch
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
 				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
+				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
+					       if|endif|menu|endmenu|source)\b/x) {
 					last;
 				}
-				$length++;
+				$help_length++ if ($has_help);
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($needs_help &&
+			    $help_length < $min_conf_desc_length) {
+				my $stat_real = get_stat_real($linenr, $ln - 1);
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a help paragraph that fully describes the config symbol with at least $min_conf_desc_length lines\n" . "$here\n$stat_real\n");
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
 # check MAINTAINERS entries
@@ -3690,20 +3840,6 @@ sub process {
 			}
 		}
 
-		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
-		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
-			my $flag = $1;
-			my $replacement = {
-				'EXTRA_AFLAGS' =>   'asflags-y',
-				'EXTRA_CFLAGS' =>   'ccflags-y',
-				'EXTRA_CPPFLAGS' => 'cppflags-y',
-				'EXTRA_LDFLAGS' =>  'ldflags-y',
-			};
-
-			WARN("DEPRECATED_VARIABLE",
-			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
-		}
-
 # check for DT compatible documentation
 		if (defined $root &&
 			(($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*compatible\s*=\s*\"/) ||
@@ -3735,6 +3871,18 @@ sub process {
 			}
 		}
 
+# Check for RGMII phy-mode with delay on PCB
+		if ($realfile =~ /\.(dts|dtsi|dtso)$/ &&
+		    $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			my $prop = $1;
+			my $mode = get_quoted_string($line, $rawline);
+			if ($mode =~ /^"rgmii(?:|-rxid|-txid)"$/) {
+				WARN("UNCOMMENTED_RGMII_MODE",
+				     "$prop $mode without comment -- delays on the PCB should be described, otherwise use \"rgmii-id\"\n" . $herecurr);
+			}
+		}
+
 # check for using SPDX license tag at beginning of files
 		if ($realline == $checklicenseline) {
 			if ($rawline =~ /^[ \+]\s*\#\!\s*\//) {
@@ -3743,7 +3891,7 @@ sub process {
 				my $comment = "";
 				if ($realfile =~ /\.(h|s|S)$/) {
 					$comment = '/*';
-				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
+				} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
 					$comment = '//';
 				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc|yaml)$/) {
 					$comment = '#';
@@ -3770,7 +3918,7 @@ sub process {
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
 					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
-					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
+					    $spdx_license !~ /GPL-2\.0(?:-only)? OR BSD-2-Clause/) {
 						my $msg_level = \&WARN;
 						$msg_level = \&CHK if ($file);
 						if (&{$msg_level}("SPDX_LICENSE_TAG",
@@ -3780,18 +3928,23 @@ sub process {
 							$fixed[$fixlinenr] =~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
 						}
 					}
+					if ($realfile =~ m@^include/dt-bindings/@ &&
+					    $spdx_license !~ /GPL-2\.0(?:-only)? OR \S+/) {
+						WARN("SPDX_LICENSE_TAG",
+						     "DT binding headers should be licensed (GPL-2.0-only OR .*)\n" . $herecurr);
+					}
 				}
 			}
 		}
 
 # check for embedded filenames
-		if ($rawline =~ /^\+.*\Q$realfile\E/) {
+		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
 			WARN("EMBEDDED_FILENAME",
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts|env)$/);
+		next if ($realfile !~ /\.(h|c|rs|s|S|sh|dtsi|dts|env)$/);
 
 # check for using SPDX-License-Identifier on the wrong line number
 		if ($realline != $checklicenseline &&
@@ -3857,7 +4010,7 @@ sub process {
 			}
 
 			if ($msg_type ne "" &&
-			    (show_type("LONG_LINE") || show_type($msg_type))) {
+			    show_type("LONG_LINE") && show_type($msg_type)) {
 				my $msg_level = \&WARN;
 				$msg_level = \&CHK if ($file);
 				&{$msg_level}($msg_type,
@@ -3878,7 +4031,7 @@ sub process {
 		if ($realfile =~ /\.S$/ &&
 		    $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
 			WARN("AVOID_L_PREFIX",
-			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
+			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
 		if ($u_boot) {
@@ -4000,16 +4153,6 @@ sub process {
 			}
 		}
 
-# Block comment styles
-# Networking with an initial /*
-		if ($realfile =~ m@^(drivers/net/|net/)@ &&
-		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
-		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 3) { # Do not warn about the initial copyright comment block after SPDX-License-Identifier
-			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
-			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
-		}
-
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
@@ -4058,7 +4201,7 @@ sub process {
 		if ($prevline =~ /^[\+ ]};?\s*$/ &&
 		    $line =~ /^\+/ &&
 		    !($line =~ /^\+\s*$/ ||
-		      $line =~ /^\+\s*EXPORT_SYMBOL/ ||
+		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param|ALLOW_ERROR_INJECTION)/ ||
 		      $line =~ /^\+\s*MODULE_/i ||
 		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
 		      $line =~ /^\+[a-z_]*init/ ||
@@ -4826,12 +4969,12 @@ sub process {
 			}
 		}
 
-# avoid BUG() or BUG_ON()
-		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
+# do not use BUG() or variants
+		if ($line =~ /\b(?!AA_|BUILD_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
 			my $msg_level = \&WARN;
 			$msg_level = \&CHK if ($file);
 			&{$msg_level}("AVOID_BUG",
-				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);
+				      "Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants\n" . $herecurr);
 		}
 
 # avoid LINUX_VERSION_CODE
@@ -5052,7 +5195,7 @@ sub process {
 				if|for|while|switch|return|case|
 				volatile|__volatile__|
 				__attribute__|format|__extension__|
-				asm|__asm__)$/x)
+				asm|__asm__|scoped_guard)$/x)
 			{
 			# cpp #define statements have non-optional spaces, ie
 			# if there is a space between the name and the open
@@ -5513,9 +5656,9 @@ sub process {
 			}
 		}
 
-# check for unnecessary parentheses around comparisons in if uses
-# when !drivers/staging or command-line uses --strict
-		if (($realfile !~ m@^(?:drivers/staging/)@ || $check_orig) &&
+# check for unnecessary parentheses around comparisons
+# except in drivers/staging
+		if (($realfile !~ m@^(?:drivers/staging/)@) &&
 		    $perl_version_ok && defined($stat) &&
 		    $stat =~ /(^.\s*if\s*($balanced_parens))/) {
 			my $if_stat = $1;
@@ -5683,6 +5826,7 @@ sub process {
 		    defined($stat) && defined($cond) &&
 		    $line =~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
 			my ($s, $c) = ($stat, $cond);
+			my $fixed_assign_in_if = 0;
 
 			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
 				if (ERROR("ASSIGN_IN_IF",
@@ -5707,6 +5851,7 @@ sub process {
 						$newline .= ')';
 						$newline .= " {" if (defined($brace));
 						fix_insert_line($fixlinenr + 1, $newline);
+						$fixed_assign_in_if = 1;
 					}
 				}
 			}
@@ -5730,8 +5875,20 @@ sub process {
 					$stat_real = "[...]\n$stat_real";
 				}
 
-				ERROR("TRAILING_STATEMENTS",
-				      "trailing statements should be on next line\n" . $herecurr . $stat_real);
+				if (ERROR("TRAILING_STATEMENTS",
+					  "trailing statements should be on next line\n" . $herecurr . $stat_real) &&
+				    !$fixed_assign_in_if &&
+				    $cond_lines == 0 &&
+				    $fix && $perl_version_ok &&
+				    $fixed[$fixlinenr] =~ /^\+(\s*)((?:if|while|for)\s*$balanced_parens)\s*(.*)$/) {
+					my $indent = $1;
+					my $test = $2;
+					my $rest = rtrim($4);
+					if ($rest =~ /;$/) {
+						$fixed[$fixlinenr] = "\+$indent$test";
+						fix_insert_line($fixlinenr + 1, "$indent\t$rest");
+					}
+				}
 			}
 		}
 
@@ -5829,16 +5986,20 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
+#Ignore ETHTOOL_LINK_MODE_<foo> variants
+			    $var !~ /^ETHTOOL_LINK_MODE_/ &&
 #Ignore SI style variants like nS, mV and dB
 #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
 			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
-				while ($var =~ m{($Ident)}g) {
+				while ($var =~ m{\b($Ident)}g) {
 					my $word = $1;
 					next if ($word !~ /[A-Z][a-z]|[a-z][A-Z]/);
 					if ($check) {
@@ -5888,9 +6049,9 @@ sub process {
 			}
 		}
 
-# multi-statement macros should be enclosed in a do while loop, grab the
-# first statement and ensure its the whole macro if its not enclosed
-# in a known good container
+# Usually multi-statement macros should be enclosed in a do {} while
+# (0) loop.  Grab the first statement and ensure its the whole macro
+# if its not enclosed in a known good container
 		if ($realfile !~ m@/vmlinux.lds.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s*$Ident(\()?/) {
 			my $ln = $linenr;
@@ -5943,10 +6104,13 @@ sub process {
 
 			my $exceptions = qr{
 				$Declare|
+				# named exceptions
 				module_param_named|
 				MODULE_PARM_DESC|
 				DECLARE_PER_CPU|
 				DEFINE_PER_CPU|
+				static_assert|
+				# declaration primitives
 				__typeof__\(|
 				union|
 				struct|
@@ -5968,6 +6132,7 @@ sub process {
 			    $dstat !~ /$exceptions/ &&
 			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
 			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
+			    $dstat !~ /^case\b/ &&					# case ...
 			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
 			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
@@ -5980,11 +6145,11 @@ sub process {
 					ERROR("MULTISTATEMENT_MACRO_USE_DO_WHILE",
 					      "Macros starting with if should be enclosed by a do - while loop to avoid possible if/else logic defects\n" . "$herectx");
 				} elsif ($dstat =~ /;/) {
-					ERROR("MULTISTATEMENT_MACRO_USE_DO_WHILE",
-					      "Macros with multiple statements should be enclosed in a do - while loop\n" . "$herectx");
+					WARN("MULTISTATEMENT_MACRO_USE_DO_WHILE",
+					      "Non-declarative macros with multiple statements should be enclosed in a do - while loop\n" . "$herectx\nBUT SEE:\n$DO_WHILE_0_ADVICE");
 				} else {
 					ERROR("COMPLEX_MACRO",
-					      "Macros with complex values should be enclosed in parentheses\n" . "$herectx");
+					      "Macros with complex values should be enclosed in parentheses\n" . "$herectx\nBUT SEE:\n$DO_WHILE_0_ADVICE");
 				}
 
 			}
@@ -6026,6 +6191,12 @@ sub process {
 					CHK("MACRO_ARG_PRECEDENCE",
 					    "Macro argument '$arg' may be better as '($arg)' to avoid precedence issues\n" . "$herectx");
 				}
+
+# check if this is an unused argument
+				if ($define_stmt !~ /\b$arg\b/ && $define_stmt) {
+					WARN("MACRO_ARG_UNUSED",
+					     "Argument '$arg' is not used in function-like macro\n" . "$herectx");
+				}
 			}
 
 # check for macros with flow control, but without ## concatenation
@@ -6040,6 +6211,9 @@ sub process {
 
 # check for line continuations outside of #defines, preprocessor #, and asm
 
+		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
+		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
+		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
 		} else {
 			if ($prevline !~ /^..*\\$/ &&
 			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
@@ -6566,11 +6740,11 @@ sub process {
 			# ignore udelay's < 10, however
 			if (! ($delay < 10) ) {
 				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				    "usleep_range is preferred over udelay; see function description of usleep_range() and udelay().\n" . $herecurr);
 			}
 			if ($delay > 2000) {
 				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\n" . $herecurr);
+				     "long udelay - prefer mdelay; see function description of mdelay().\n" . $herecurr);
 			}
 		}
 
@@ -6578,7 +6752,7 @@ sub process {
 		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
 			if ($1 < 20) {
 				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				     "msleep < 20ms can sleep for up to 20ms; see function description of msleep().\n" . $herecurr);
 			}
 		}
 
@@ -6886,7 +7060,7 @@ sub process {
 					    ($extension eq "f" &&
 					     defined $qualifier && $qualifier !~ /^w/) ||
 					    ($extension eq "4" &&
-					     defined $qualifier && $qualifier !~ /^cc/)) {
+					     defined $qualifier && $qualifier !~ /^c(?:[hlbc]|hR)$/)) {
 						$bad_specifier = $specifier;
 						last;
 					}
@@ -6900,15 +7074,19 @@ sub process {
 				}
 				if ($bad_specifier ne "") {
 					my $stat_real = get_stat_real($linenr, $lc);
+					my $msg_level = \&WARN;
 					my $ext_type = "Invalid";
 					my $use = "";
 					if ($bad_specifier =~ /p[Ff]/) {
 						$use = " - use %pS instead";
 						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
+					} elsif ($bad_specifier =~ /pA/) {
+						$use =  " - '%pA' is only intended to be used from Rust code";
+						$msg_level = \&ERROR;
 					}
 
-					WARN("VSPRINTF_POINTER_EXTENSION",
-					     "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
+					&{$msg_level}("VSPRINTF_POINTER_EXTENSION",
+						      "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
 				}
 			}
 		}
@@ -6973,6 +7151,36 @@ sub process {
 #			}
 #		}
 
+# strcpy uses that should likely be strlcpy
+		if ($line =~ /\bstrcpy\s*\(/) {
+			WARN("STRCPY",
+			     "Prefer strlcpy over strcpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
+		}
+# strncpy uses that should likely be strlcpy or strlcpy_pad
+		if ($line =~ /\bstrncpy\s*\(/) {
+			WARN("STRNCPY",
+			     "Prefer strlcpy, strlcpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
+		}
+
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
+		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*"\%s"\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&
@@ -7005,11 +7213,11 @@ sub process {
 			my $max = $7;
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			}
 		}
 
@@ -7077,6 +7285,21 @@ sub process {
 				     "arguments for function declarations should follow identifier\n" . $herecurr);
 			}
 
+		} elsif ($realfile =~ /\.c$/ && defined $stat &&
+		    $stat =~ /^\+extern struct\s+(\w+)\s+(\w+)\[\];/)
+		{
+			my ($st_type, $st_name) = ($1, $2);
+
+			for my $s (keys %maybe_linker_symbol) {
+			    #print "Linker symbol? $st_name : $s\n";
+			    goto LIKELY_LINKER_SYMBOL
+				if $st_name =~ /$s/;
+			}
+			WARN("AVOID_EXTERNS",
+			     "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
+			     . "is this a linker symbol ?\n" . $herecurr);
+		  LIKELY_LINKER_SYMBOL:
+
 		} elsif ($realfile =~ /\.c$/ && defined $stat &&
 		    $stat =~ /^.\s*extern\s+/)
 		{
@@ -7145,14 +7368,16 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
+# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
 			my $newfunc = "kmalloc_array";
+			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
@@ -7169,7 +7394,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}
@@ -7183,7 +7408,7 @@ sub process {
 		}
 
 # check for alloc argument mismatch
-		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
+		if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
 			WARN("ALLOC_ARRAY_ARGS",
 			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
@@ -7211,8 +7436,8 @@ sub process {
 
 # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
 		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^${CONFIG_}/) {
-			ERROR("IS_ENABLED_CONFIG",
-			     "IS_ENABLED($1) must be used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
+			WARN("IS_ENABLED_CONFIG",
+			     "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
 		}
 
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
@@ -7386,6 +7611,16 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*\}(?:\s*__packed)?\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if (ERROR("FLEXIBLE_ARRAY",
+				  "Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
+			    $1 == '0' && $fix) {
+				$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
@@ -7403,6 +7638,30 @@ sub process {
 			}
 		}
 
+# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
+		our $rcu_trace_funcs = qr{(?x:
+			rcu_read_lock_trace |
+			rcu_read_lock_trace_held |
+			rcu_read_unlock_trace |
+			call_rcu_tasks_trace |
+			synchronize_rcu_tasks_trace |
+			rcu_barrier_tasks_trace |
+			rcu_request_urgent_qs_task
+		)};
+		our $rcu_trace_paths = qr{(?x:
+			kernel/bpf/ |
+			include/linux/bpf |
+			net/bpf/ |
+			kernel/rcu/ |
+			include/linux/rcu
+		)};
+		if ($line =~ /\b($rcu_trace_funcs)\s*\(/) {
+			if ($realfile !~ m{^$rcu_trace_paths}) {
+				WARN("RCU_TASKS_TRACE",
+				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
+			}
+		}
+
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
@@ -7544,6 +7803,13 @@ sub process {
 				WARN("MODULE_LICENSE",
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
+			if (!$file && $extracted_string eq '"GPL v2"') {
+				if (WARN("MODULE_LICENSE",
+				     "Prefer \"GPL\" over \"GPL v2\" - see commit bf7fbeeae6db (\"module: Cure the MODULE_LICENSE \"GPL\" vs. \"GPL v2\" bogosity\")\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\bMODULE_LICENSE\s*\(\s*"GPL v2"\s*\)/MODULE_LICENSE("GPL")/;
+				}
+			}
 		}
 
 # check for sysctl duplicate constants
@@ -7551,6 +7817,31 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# Check that *_device_id tables have sentinel entries.
+		if (defined $stat && $line =~ /struct\s+$dev_id_types\s+\w+\s*\[\s*\]\s*=\s*\{/) {
+			my $stripped = $stat;
+
+			# Strip diff line prefixes.
+			$stripped =~ s/(^|\n)./$1/g;
+			# Line continuations.
+			$stripped =~ s/\\\n/\n/g;
+			# Strip whitespace, empty strings, zeroes, and commas.
+			$stripped =~ s/""//g;
+			$stripped =~ s/0x0//g;
+			$stripped =~ s/[\s$;,0]//g;
+			# Strip field assignments.
+			$stripped =~ s/\.$Ident=//g;
+
+			if (!(substr($stripped, -4) eq "{}};" ||
+			      substr($stripped, -6) eq "{{}}};" ||
+			      $stripped =~ /ISAPNP_DEVICE_SINGLE_END}};$/ ||
+			      $stripped =~ /ISAPNP_CARD_END}};$/ ||
+			      $stripped =~ /NULL};$/ ||
+			      $stripped =~ /PCMCIA_DEVICE_NULL};$/)) {
+				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
+			}
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
@@ -7575,6 +7866,12 @@ sub process {
 		ERROR("NOT_UNIFIED_DIFF",
 		      "Does not appear to be a unified-diff format patch\n");
 	}
+	if ($is_patch && $has_commit_log && $chk_fixes_tag) {
+		if ($needs_fixes_tag ne "" && !$is_revert && !$fixes_tag) {
+			WARN("MISSING_FIXES_TAG",
+				 "The commit message has '$needs_fixes_tag', perhaps it also needs a 'Fixes:' tag?\n");
+		}
+	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index ebd06ae642c..8d608f61bf3 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -6,6 +6,7 @@ from argparse import ArgumentParser
 from ply import lex, yacc
 import locale
 import traceback
+import fnmatch
 import sys
 import git
 import re
@@ -28,6 +29,21 @@ class SPDXdata(object):
         self.licenses = [ ]
         self.exceptions = { }
 
+class dirinfo(object):
+    def __init__(self):
+        self.missing = 0
+        self.total = 0
+        self.files = []
+
+    def update(self, fname, basedir, miss):
+        self.total += 1
+        self.missing += miss
+        if miss:
+            fname = './' + fname
+            bdir = os.path.dirname(fname)
+            if bdir == basedir.rstrip('/'):
+                self.files.append(fname)
+
 # Read the spdx data from the LICENSES directory
 def read_spdxdata(repo):
 
@@ -91,11 +107,25 @@ class id_parser(object):
         self.parser = yacc.yacc(module = self, write_tables = False, debug = False)
         self.lines_checked = 0
         self.checked = 0
+        self.excluded = 0
         self.spdx_valid = 0
         self.spdx_errors = 0
+        self.spdx_dirs = {}
+        self.dirdepth = -1
+        self.basedir = '.'
         self.curline = 0
         self.deepest = 0
 
+    def set_dirinfo(self, basedir, dirdepth):
+        if dirdepth >= 0:
+            self.basedir = basedir
+            bdir = basedir.lstrip('./').rstrip('/')
+            if bdir != '':
+                parts = bdir.split('/')
+            else:
+                parts = []
+            self.dirdepth = dirdepth + len(parts)
+
     # Validate License and Exception IDs
     def validate(self, tok):
         id = tok.value.upper()
@@ -167,6 +197,7 @@ class id_parser(object):
     def parse_lines(self, fd, maxlines, fname):
         self.checked += 1
         self.curline = 0
+        fail = 1
         try:
             for line in fd:
                 line = line.decode(locale.getpreferredencoding(False), errors='ignore')
@@ -183,15 +214,22 @@ class id_parser(object):
                 # Remove trailing xml comment closure
                 if line.strip().endswith('-->'):
                     expr = expr.rstrip('-->').strip()
+                # Remove trailing Jinja2 comment closure
+                if line.strip().endswith('#}'):
+                    expr = expr.rstrip('#}').strip()
                 # Special case for SH magic boot code files
                 if line.startswith('LIST \"'):
                     expr = expr.rstrip('\"').strip()
+                # Remove j2 comment closure
+                if line.startswith('{#'):
+                    expr = expr.rstrip('#}').strip()
                 self.parse(expr)
                 self.spdx_valid += 1
                 #
                 # Should we check for more SPDX ids in the same file and
                 # complain if there are any?
                 #
+                fail = 0
                 break
 
         except ParserException as pe:
@@ -200,31 +238,105 @@ class id_parser(object):
                 tok = pe.tok.value
                 sys.stdout.write('%s: %d:%d %s: %s\n' %(fname, self.curline, col, pe.txt, tok))
             else:
-                sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, col, pe.txt))
+                sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, pe.txt))
             self.spdx_errors += 1
 
-def scan_git_tree(tree):
+        if fname == '-':
+            return
+
+        base = os.path.dirname(fname)
+        if self.dirdepth > 0:
+            parts = base.split('/')
+            i = 0
+            base = '.'
+            while i < self.dirdepth and i < len(parts) and len(parts[i]):
+                base += '/' + parts[i]
+                i += 1
+        elif self.dirdepth == 0:
+            base = self.basedir
+        else:
+            base = './' + base.rstrip('/')
+        base += '/'
+
+        di = self.spdx_dirs.get(base, dirinfo())
+        di.update(fname, base, fail)
+        self.spdx_dirs[base] = di
+
+class pattern(object):
+    def __init__(self, line):
+        self.pattern = line
+        self.match = self.match_file
+        if line == '.*':
+            self.match = self.match_dot
+        elif line.endswith('/'):
+            self.pattern = line[:-1]
+            self.match = self.match_dir
+        elif line.startswith('/'):
+            self.pattern = line[1:]
+            self.match = self.match_fn
+
+    def match_dot(self, fpath):
+        return os.path.basename(fpath).startswith('.')
+
+    def match_file(self, fpath):
+        return os.path.basename(fpath) == self.pattern
+
+    def match_fn(self, fpath):
+        return fnmatch.fnmatchcase(fpath, self.pattern)
+
+    def match_dir(self, fpath):
+        if self.match_fn(os.path.dirname(fpath)):
+            return True
+        return fpath.startswith(self.pattern)
+
+def exclude_file(fpath):
+    for rule in exclude_rules:
+        if rule.match(fpath):
+            return True
+    return False
+
+def scan_git_tree(tree, basedir, dirdepth):
+    parser.set_dirinfo(basedir, dirdepth)
     for el in tree.traverse():
-        # Exclude stuff which would make pointless noise
-        # FIXME: Put this somewhere more sensible
-        if el.path.startswith("LICENSES"):
-            continue
-        if el.path.find("license-rules.rst") >= 0:
-            continue
         if not os.path.isfile(el.path):
             continue
+        if exclude_file(el.path):
+            parser.excluded += 1
+            continue
         with open(el.path, 'rb') as fd:
             parser.parse_lines(fd, args.maxlines, el.path)
 
-def scan_git_subtree(tree, path):
+def scan_git_subtree(tree, path, dirdepth):
     for p in path.strip('/').split('/'):
         tree = tree[p]
-    scan_git_tree(tree)
+    scan_git_tree(tree, path.strip('/'), dirdepth)
+
+def read_exclude_file(fname):
+    rules = []
+    if not fname:
+        return rules
+    with open(fname) as fd:
+        for line in fd:
+            line = line.strip()
+            if line.startswith('#'):
+                continue
+            if not len(line):
+                continue
+            rules.append(pattern(line))
+    return rules
 
 if __name__ == '__main__':
 
     ap = ArgumentParser(description='SPDX expression checker')
     ap.add_argument('path', nargs='*', help='Check path or file. If not given full git tree scan. For stdin use "-"')
+    ap.add_argument('-d', '--dirs', action='store_true',
+                    help='Show [sub]directory statistics.')
+    ap.add_argument('-D', '--depth', type=int, default=-1,
+                    help='Directory depth for -d statistics. Default: unlimited')
+    ap.add_argument('-e', '--exclude',
+                    help='File containing file patterns to exclude. Default: scripts/spdxexclude')
+    ap.add_argument('-f', '--files', action='store_true',
+                    help='Show files without SPDX.')
     ap.add_argument('-m', '--maxlines', type=int, default=15,
                     help='Maximum number of lines to scan in a file. Default 15')
     ap.add_argument('-v', '--verbose', action='store_true', help='Verbose statistics output')
@@ -258,6 +370,15 @@ if __name__ == '__main__':
         sys.stderr.write('%s\n' %traceback.format_exc())
         sys.exit(1)
 
+    try:
+        fname = args.exclude
+        if not fname:
+            fname = os.path.join(os.path.dirname(__file__), 'spdxexclude')
+        exclude_rules = read_exclude_file(fname)
+    except Exception as ex:
+        sys.stderr.write('FAIL: Reading exclude file %s: %s\n' %(fname, ex))
+        sys.exit(1)
+
     try:
         if len(args.path) and args.path[0] == '-':
             stdin = os.fdopen(sys.stdin.fileno(), 'rb')
@@ -268,13 +389,21 @@ if __name__ == '__main__':
                     if os.path.isfile(p):
                         parser.parse_lines(open(p, 'rb'), args.maxlines, p)
                     elif os.path.isdir(p):
-                        scan_git_subtree(repo.head.reference.commit.tree, p)
+                        scan_git_subtree(repo.head.reference.commit.tree, p,
+                                         args.depth)
                     else:
                         sys.stderr.write('path %s does not exist\n' %p)
                         sys.exit(1)
             else:
                 # Full git tree scan
-                scan_git_tree(repo.head.commit.tree)
+                scan_git_tree(repo.head.commit.tree, '.', args.depth)
+
+            ndirs = len(parser.spdx_dirs)
+            dirsok = 0
+            if ndirs:
+                for di in parser.spdx_dirs.values():
+                    if not di.missing:
+                        dirsok += 1
 
             if args.verbose:
                 sys.stderr.write('\n')
@@ -283,10 +412,41 @@ if __name__ == '__main__':
                 sys.stderr.write('License IDs        %12d\n' %len(spdx.licenses))
                 sys.stderr.write('Exception IDs      %12d\n' %len(spdx.exceptions))
                 sys.stderr.write('\n')
+                sys.stderr.write('Files excluded:    %12d\n' %parser.excluded)
                 sys.stderr.write('Files checked:     %12d\n' %parser.checked)
                 sys.stderr.write('Lines checked:     %12d\n' %parser.lines_checked)
-                sys.stderr.write('Files with SPDX:   %12d\n' %parser.spdx_valid)
+                if parser.checked:
+                    pc = int(100 * parser.spdx_valid / parser.checked)
+                    sys.stderr.write('Files with SPDX:   %12d %3d%%\n' %(parser.spdx_valid, pc))
+                    missing = parser.checked - parser.spdx_valid
+                    mpc = int(100 * missing / parser.checked)
+                    sys.stderr.write('Files without SPDX:%12d %3d%%\n' %(missing, mpc))
                 sys.stderr.write('Files with errors: %12d\n' %parser.spdx_errors)
+                if ndirs:
+                    sys.stderr.write('\n')
+                    sys.stderr.write('Directories accounted: %8d\n' %ndirs)
+                    pc = int(100 * dirsok / ndirs)
+                    sys.stderr.write('Directories complete:  %8d %3d%%\n' %(dirsok, pc))
+
+            if ndirs and ndirs != dirsok and args.dirs:
+                if args.verbose:
+                    sys.stderr.write('\n')
+                sys.stderr.write('Incomplete directories: SPDX in Files\n')
+                for f in sorted(parser.spdx_dirs.keys()):
+                    di = parser.spdx_dirs[f]
+                    if di.missing:
+                        valid = di.total - di.missing
+                        pc = int(100 * valid / di.total)
+                        sys.stderr.write('    %-80s: %5d of %5d  %3d%%\n' %(f, valid, di.total, pc))
+
+            if ndirs and ndirs != dirsok and args.files:
+                if args.verbose or args.dirs:
+                    sys.stderr.write('\n')
+                sys.stderr.write('Files without SPDX:\n')
+                for f in sorted(parser.spdx_dirs.keys()):
+                    di = parser.spdx_dirs[f]
+                    for f in sorted(di.files):
+                        sys.stderr.write('    %s\n' %f)
 
             sys.exit(0)
 
-- 
2.43.0

